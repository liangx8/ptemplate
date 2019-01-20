data class Person(
    val name:String,
    val age:Int
)

fun main(args: Array<String>) {
    val mike = Person("Mike",17)
    val (name,age)=mike
    println("My name is $name, I'm $age")
}