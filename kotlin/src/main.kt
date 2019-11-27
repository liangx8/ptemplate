import java.net.*
import java.io.*
import java.nio.charset.Charset

fun notNullReturn(src:String?):String{
    return src!!
}
fun urlExample(){
    val url = URL("http://pfa.rcgreed.bid/pfa/x.json")
    val httpCon = url.openConnection() as HttpURLConnection
    httpCon.setDoOutput(true)
    httpCon.setRequestMethod("PUT")
    val out = DataOutputStream(httpCon.getOutputStream())
    out.write(byteArrayOf(2,5))
    val acn = "理财".toByteArray(Charset.forName("UTF-8"))
    out.write(byteArrayOf(acn.size.toByte()))
    out.write(acn)
    out.close()
    val ins=InputStreamReader(httpCon.getInputStream())
    while(true){
        val c=ins.read()
        if (c < 0) break
        print(c.toChar())
    }
}
fun main(args: Array<String>) {
    print(notNullReturn(null))
}