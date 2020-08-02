import ammonite.ops._

import $file.shared
import shared._
import $ivy.`org.lz4:lz4-java:1.7.1`

import net.jpountz.lz4._

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

def restorePath(prefix: String = "dev-edition-") = {

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

def backup(prefix: String = "dev-edition-") = {
  val restPath = restorePath(prefix)
  println(s"Backing up from $restPath to $backupPath...")
  restPath |> read.bytes |> decompressLz4 |> overwriteTo(backupPath)
  println(s"Written from $restPath to $backupPath")
}

def restore(prefix: String = "dev-edition-") = {
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

@main
def main(mode: String = "backup", prefix: String = "dev-edition-") = {
  if (!Set("backup", "restore").contains(mode)) {
    sys.error("""--mode can be one of ["backup", "restore"]!""")
  }
  if (mode == "backup") {
    backup(prefix)
  } else {
    restore(prefix)
  }
}
