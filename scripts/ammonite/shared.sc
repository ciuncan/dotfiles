@annotation.tailrec
def ask[T](prompt: String, convert: PartialFunction[String, T]): T = {
  println(prompt)
  println()
  val input = scala.io.StdIn.readLine.trim
  convert.lift(input) match {
    case Some(value) => value
    case None =>
      println(s"Unexpected input: $input. Hit Ctrl+c to exit.")
      ask(prompt, convert)
  }
}

def askCont[T](prompt: String, cont: String => Option[T]): T = {
  ask(prompt, new PartialFunction[String, T] {
    private var lastResult: Option[T] = None
    override def apply(v1: String): T = lastResult.get
    override def isDefinedAt(x: String): Boolean = {
      lastResult = cont(x)
      lastResult.nonEmpty
    }
  })
}

def ask(prompt: String): String = ask(prompt, { case s: String => s })
def askOpt(prompt: String): Option[String] = ask(prompt + " (Optional)", {
  case s if s.trim.isEmpty  => None
  case s                    => Some(s)
})

def askYesNoExit(prompt: String): Boolean = ask(prompt + "\n[y]es [n]o e[x]it", {
  case "Y" | "y" => true
  case "N" | "n" => false
  case "X" | "x" => sys.exit()
})

def md5(arr: Array[Byte]): String = {
  val digest = java.security.MessageDigest.getInstance("MD5").digest(arr)
  java.util.Base64.getEncoder.encodeToString(digest)
}
