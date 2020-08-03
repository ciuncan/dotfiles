import ammonite.ops._

import $file.shared
import shared._

import $ivy.`com.lihaoyi::requests:0.6.5`
import $ivy.`com.lihaoyi::ujson:1.2.0`
import $ivy.`org.lz4:lz4-java:1.7.1`
import $ivy.`io.lemonlabs::scala-uri:2.2.4`

import io.lemonlabs.uri.{Url, AbsoluteUrl}
import net.jpountz.lz4.LZ4Factory

import java.nio.{ByteBuffer, ByteOrder}

def bytesToStr(arr: Array[Byte]): String = new String(arr, "UTF-8")
def strToBytes(str: String): Array[Byte] = str.getBytes("UTF-8")

def jsonCompact(str: String): String = ujson.read(str).toString
def jsonPrettify(str: String): String = ujson.read(str).render(4, false)

def overwriteTo(path: Path): Array[Byte] => Unit = write.over(path, _)

def intToBytes(i: Int): Array[Byte] = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(i).array()
def bytesToInt(arr: Array[Byte]): Int = ByteBuffer.wrap(arr).order(ByteOrder.LITTLE_ENDIAN).getInt


val mozHeaderBytes = "mozLz40\u0000" |> strToBytes

def compressLz4(plain: Array[Byte]): Array[Byte] = {
  val compressor = LZ4Factory.safeInstance.fastCompressor()

  val compressedJson = plain |> bytesToStr |> jsonCompact |> strToBytes |> compressor.compress

  val sizeHeader = plain.length |> intToBytes

  (mozHeaderBytes.iterator ++ sizeHeader.iterator ++ compressedJson.iterator).toArray
}

def decompressLz4(compressed: Array[Byte]): Array[Byte] = {
  val size = compressed.iterator.drop(mozHeaderBytes.length).take(4).toArray |> bytesToInt

  val decompressor = LZ4Factory.safeInstance.safeDecompressor()

  val decompressedBytes = decompressor.decompress(
    compressed,
    mozHeaderBytes.length + 4,
    compressed.length - mozHeaderBytes.length - 4,
    size
  )
  decompressedBytes |> bytesToStr |> jsonPrettify |> strToBytes
}

val backupPath = home/'dotfiles/"search.json.mozlz4.json"

def restorePath(prefix: String) = {

  val firefoxConfigFolderContent = ls! home/".mozilla"/'firefox
  println(s"Your firefox config contains following files:\n${firefoxConfigFolderContent.mkString("\n")}\n")


  val suffix = s".${prefix}default"
  var maybeOnlyProfileFolder = firefoxConfigFolderContent |? (_.last.endsWith(suffix))

  var proceed = false

  while (!proceed) {
    while (maybeOnlyProfileFolder.size > 1 || maybeOnlyProfileFolder.size == 0) {
      val nameFilter = ask(s"Profile folder search got ${
        if (maybeOnlyProfileFolder.size > 1)
          s"more than one"
        else
          "no"
      } match for suffix: ${suffix}.\nPlease enter part of correct folder name to proceed...")
      maybeOnlyProfileFolder = firefoxConfigFolderContent |? (_.last.contains(nameFilter))
    }
    var shouldAsk = true
    proceed = askYesNoExit(s"Proceed with ${maybeOnlyProfileFolder.headOption}?")
    if (!proceed) {
      maybeOnlyProfileFolder = firefoxConfigFolderContent
    }
  }
  maybeOnlyProfileFolder.head/"search.json.mozlz4"
}

def backup(prefix: String) = {
  val restPath = restorePath(prefix)
  println(s"Backing up from $restPath to $backupPath...")
  restPath |> read.bytes |> decompressLz4 |> overwriteTo(backupPath)
  println(s"Written from $restPath to $backupPath")
}

def restore(prefix: String) = {
  val restPath = restorePath(prefix)
  val oldRestorePath = restPath/up/s"${restPath.last}.bak"
  if (exists(oldRestorePath)) {
    if (askYesNoExit(s"$oldRestorePath already exists, would you like to overwrite it?")) {
      os.copy(restPath, oldRestorePath, replaceExisting = true)
      println(s"Copied from $restPath to $oldRestorePath")
    }
  } else {
      os.copy(restPath, oldRestorePath)
  }
  backupPath |> read.bytes |> compressLz4 |> overwriteTo(restPath)
  println(s"Written from $backupPath to $restPath")
}

def add(prefix: String) = {
  def addSearchEngine(jsonString: String): String = {
    val root = ujson.Obj(ujson.read(jsonString).obj)
    val engineOrders = root("engines").arr
      .map(o => o.obj("_name").str -> o.obj("_metaData").obj("order").num.toInt)
      .toMap

    println("Current engines: ")
    engineOrders.toSeq
      .sortBy(_._2)
      .foreach({ case (name, order) => println(s"$order => $name") })

    val newConfig = askSearchEngineConfig(nextOrder = engineOrders.values.max + 1)
    val desiredOrder = newConfig("_metaData").obj("order").num.toInt

    engineOrders
      .filter({ case (_, order) => order >= desiredOrder })
      .foreach({ case (name, oldOrder) =>
        val found = root("engines").arr.find(_.obj("_name").str == name)
        println(s"Checked $name, found = $found")
        found.get.obj("_metaData").obj("order") = oldOrder + 1
      })

    root("engines").arr += newConfig
    root("engines").arr.sortInPlaceBy(_.obj("_metaData").obj("order").num)
    root.render(4, false)
  }
  backupPath |> read |> addSearchEngine |> strToBytes |> overwriteTo(backupPath)
}

def getFaviconDataUrl(domain: String): String = {
  val faviconResp = requests.get(s"https://$domain/favicon.ico")
  val dataString = faviconResp.data.array |> java.util.Base64.getEncoder.encodeToString
  s"data:${faviconResp.contentType.get};base64,$dataString"
}

def askSearchEngineConfig(nextOrder: Int) = {
  val name = ask("Name:")
  val shortName = askOpt("Short Name:")
  val alias = askOpt("Alias:")
  val description = askOpt("Description:")
  val order = askOpt(s"Order (will default to $nextOrder):").map(_.toInt)
  val url = ask(
    "Search absolute url ({searchTerms} for search term):\n" +
      "Example: https://github.com/search?q={searchTerms}&ref=opensearch",
    {
      case s if Url.parse(s).isInstanceOf[AbsoluteUrl] && s.contains("{searchTerms}") => s
    }
  )
  val domain = AbsoluteUrl.parse(url).host.toString
  val decidedOrder = order.getOrElse(nextOrder)

  val result = ujson.Obj(
    "_name" -> name,
    // "__searchForm" -> "?",
    "_iconURL" -> getFaviconDataUrl(domain),
    // "_loadPath" -> "?",
    "_metaData" -> ujson.Obj(
      // "loadPathHash" -> "?",
      "alias" -> "",
      "order" -> decidedOrder
    ),
    "_urls" -> ujson.Arr(ujson.Obj(
      "params" -> ujson.Arr(),
      "rels" -> ujson.Arr(),
      "resultDomain" -> domain,
      "template" -> url
    )),
    "_isAppProvided" -> false,
    "_orderHint" -> ujson.Null,
    "_telemetryId" -> ujson.Null,
    "queryCharset" -> "UTF-8"
  )

  shortName.foreach(result("_shortName") = _)
  description.foreach(result("description") = _)
  alias.foreach(result("_metaData")("alias") = _)

  result
}

@main
def main(op: String = "backup", prefix: String = "dev-edition-") = {
  val acceptedOps = Set("backup", "restore", "add")
  if (!acceptedOps.contains(op)) {
    sys.error(s"""--op can be one of ${acceptedOps}!""")
  }
  op match {
    case "backup"   => backup(prefix)
    case "restore"  => restore(prefix)
    case "add"      => add(prefix)
  }
}
