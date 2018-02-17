//: Playground - noun: a place where people can play

import UIKit
import Foundation

// 1 柯里化始终量产相似方法的好方法
/*

func addTo( _ adder: Int) -> (Int)-> Int {
    return {
        num in
        return num + adder
    }
}

let add10 = addTo(10)

let number = add10(5)

 */


// 2 将protocol 的方法声明为 mutating(突变)
// 当协议的继承者是struct 或者 enum时， mutating关键字修饰方法是为了能在该方法中修改 struct 或是enum的变量
// 如果不适用 mutating关键字，继承此协议的struct或者enum在此方法中更改属性时，会报错说不能改变结构体成员
/*

protocol Vehicle {
    var numberOfWheel : Int{ get }
    var color : UIColor { get }
    
    mutating func changeColor()
}

struct MyCar : Vehicle {
    let numberOfWheel: Int = 4
    var color = UIColor.blue
    
    mutating func changeColor() {
        color = .red
    }
}
*/

// 3 Sequence 序列
/*
    Swift的for...in 可以用在所有实现了了sequence的类型上，
    IntertoProtocol协议
 
    currentIndex = 0
    next() -> T?
 */


// 4 多元组 （Tuple）  元组是 (,)

/*
func swapMe2<T>(a : inout T, b: inout T){
    (a, b) = (b, a)
}


 
 
 

func divided() -> (CGRect, CGPoint, Int){
    
    let rect1 = CGRect(x: 0, y: 0, width: 0, height: 0)
    let point = CGPoint(x: 0, y: 0)
    let int = 1
    
    return (rect1, point, int)
}

let acd = divided

let one = acd().0       //CGRect
let two = acd().1       //point
let three = acd().2     //int

*/

// 5 @autoclosure 和 ??

/*
func logIfTrue(_ predicate: ()-> Bool) {
    if predicate() {
        print("Ture")
    }
}

logIfTrue({ return 2 > 1 })
logIfTrue({ 2 > 1 })

// 尾随闭包
logIfTrue { 2 > 1 }

func logIfTrue2(_ predicate: @autoclosure ()-> Bool){
    if  predicate() {
        print("True")
    }
}

// 快捷方式已经生效，
// logIfTrue2(<#T##predicate: Bool##Bool#>)
// 直接写成 @autoclosesure会自动转换 2 > 1  到 ()->Bool
logIfTrue2(2 > 1)


// ??

var level : Int?
var startLevel = 1

// ?? 表示前面的值为空的时候 ，使用后面的值
var currentLevel = level ?? startLevel

// ?? 的完全定义的方法有两个


//func ??<T>(optional : T?, defaultValue: @autoclosure ()->T?) -> T?
//func ??<T>(optional : T?, defaultValue: @autoclosure ()->T) -> T



// 其实现原理大致如下
func ??<T>(optional: T?, defaultValue: @autoclosure ()->T) -> T{
    switch optional {
    case .some(let value):
        return value
    case .none:
        return defaultValue()
    }
}

// 使用 @autoclosure的目的在于如果optional不为nil的时候，不用计算 defalutValue值
// && 和 || 符号也是使用了 @autoclosure

*/
// 6  @escaping 逃逸闭包

/*
// 支持异步回调,
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

func doWork(block: ()->()){
    block()
}

func doWorkAsync(block:@escaping ()->()){
    // 逃逸闭包
    DispatchQueue.main.async {
        block()
    }
    
//    DispatchQueue.main.sync {
//        block()
//    }
}
//
//doWork {
//    print("work")
//}

//doWorkAsync {
//    print(333)
//}



class S {
    var foo = "foo"
    
    func method1(){
        doWork {
            print(foo + " method1")
        }
        foo = "bar"
    }
    
    func method2(){
        doWorkAsync {
            print(self.foo + " method2")
        }
        foo = "bar"
    }
    
    func method3(){
        doWorkAsync {
            [weak self] in
            print(self?.foo ?? "nil" + " method3")
        }
        foo = "bar"
    }
    
}

S().method1()
S().method2()
S().method3()

// foo method1
// bar method2
// nil method3

// 另外，如果一个协议中的一个方法接受一个逃逸闭包的参数，那么实现这个协议的类或者其他在实现这个方法时也应该加上@escaping 关键字，否则报错
*/

// 7 Optional Chaining

/*
class Toy {
    let name: String
    init(name: String){
        self.name = name
    }
}

class Pet {
    var toy: Toy?
}

class Child{
    var pet: Pet?
}

let xiaoming = Child()
if let toyName = xiaoming.pet?.toy?.name {
    ///
}

extension Toy {
    func play(){
        //
    }
}

// 实际上这段代码是错误的，因为这个可能因为属性为nil而没有调用到play()方法
let playClosure = {
    (child: Child) -> () in
    child.pet?.toy?.play()
}

// 这是正确      ()等价于Void   ()? 等价于 Void?
let playClosure2 = {
    (child: Child) -> ()? in
    child.pet?.toy?.play()
}

// 使用过的时候
if let resultClosure: () = playClosure2(xiaoming) {
    // 成功
}
*/


// 8 操作符
/*
struct Vector2D {
    var x = 0.0
    var y = 0.0
}

func +(left: Vector2D, right: Vector2D)-> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}

// /Users/dingfude/Git/Swifter4.0/Swift4.0_Playground.playground:271:6: Operator implementation without matching operator declaration

// 对于新增的操作符需要告知编译器，这其实是个操作符
precedencegroup DotProductPrecedence {
    associativity : none
    higherThan : MultiplicationPrecedence
}
infix operator +* : DotProductPrecedence

func +*(left: Vector2D, right: Vector2D) -> Double{
    return left.x * right.x + left.y + right.y
}
*/


// 9 func 的参数修饰符

// inout 修饰符
/*
func incrementor(variable: inout Int) {
    variable += 1
}

var index = 0
incrementor(variable: &index)

*/


// 10 字面量表达

//ExpressibleByExtendedGraphemeClusterLiteral
//ExtendedGraphemeClusterLiteralConvertible
//ExpressibleByUnicodeScalarLiteral
/*
class Person : ExpressibleByStringLiteral {
    
    let name : String
    init(name value : String) {
        self.name = value
    }
    
    required convenience init(stringLiteral value: String){
        self.init(name: value)
    }
    
    required convenience init(unicodeScalarLiteral value: String) {
        self.init(name: value)
    }
    
    required convenience  init(extendedGraphemeClusterLiteral value: String) {
        self.init(name: value)
    }
}

let person : Person = "张三"
print(person.name)
*/

// 11 下标  扩展下标
/*
extension Array {
    subscript(input: [Int]) -> ArraySlice<Element>{
        get {
            var result = ArraySlice<Element>()
            for i in input{
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        set {
            for (index ,i) in input.enumerated() {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

var array = [1,2,3,4,5]
let newArray = array[[0, 2, 3]]
print(newArray) // [1, 3, 4]
array[[0, 2, 3]] = [-1, -3, -4]
print(array) // [-1, 2, -3, -4, -5]

*/
// 12 方法嵌套 方法中定义方法
/*
func appendQuery(url: String, key: String, value: AnyObject) ->String{
    
    func appendQueryDictionary(url: String, key: String, value: [String:AnyObject]) ->String{
        // ...
        return ""
    }
    
    func appendQueryArray(url: String, key: String, value: [AnyObject]) ->String{
        // ...
        return ""
    }
    
    func appendQuerySingle(url: String, key: String, value: AnyObject) ->String{
        // ...
        return ""
    }
    
    if let dictionary = value as? [String : AnyObject] {
        return appendQueryDictionary(url: url, key: key, value: dictionary)
    } else if let array = value as? [AnyObject] {
        return appendQueryArray(url: url, key: key, value: array)
    } else {
        return appendQuerySingle(url: url, key: key, value: value)
    }
}

*/


// 12 命名空间

// MyClass.hello()

// 命名空间 + 类名（对象） + 方法
// MyFramework.MyClass.hello()

// 另一种，对于同名的类放入两个不同类型嵌套中
/*
struct MyClassContaier1 {
    class MyClass {
        class func hello(){
            //..
        }
    }
}

struct MyClassContaier2 {
    class MyClass {
        class func hello(){
            //..
        }
    }
}

MyClassContaier1.MyClass.hello()
MyClassContaier2.MyClass.hello()

*/

// 13 typealias
/*
typealias Location = CGPoint
typealias CleanRecordShareBlock = (_ index:Int)->()
var cleanRecordShareBlock : CleanRecordShareBlock = { _ in }

// 泛型
class Person<T> { }
typealias Worker<T> = Person<T>

// 多协议合并
protocol Cat {  }
protocol Dog {  }

typealias Pat = Cat & Dog

class AAA : Pat {
    //...
}
*/

// 14 associatedtype 关联类型关键字
// 在父类或者协议中设定添加一个限定， 在子类或者实现类中指定具体的类型

// 例如自定义字面量的实现

//    public protocol ExpressibleByStringLiteral : ExpressibleByExtendedGraphemeClusterLiteral {
//        associatedtype StringLiteralType // 限定类型，在实现类中确定
//        public init(stringLiteral value: Self.StringLiteralType)
//    }
//    class Person : ExpressibleByStringLiteral {
//        typealias StringLiteralType = String
//        public init(stringLiteral value: Self.StringLiteralType)
//    }


// 15, 可变参数函数
/*
func sum(input: Int...) ->Int {
    return input.reduce(0, +)
}

print(sum(input: 1,2,3,4,5)) // 15

// 并且可变参数不必限定在最后一个参数
// 一个方法只能接受一个参数是可变的，必须是同一种类型
func myFunc(numbers: Int..., string: String){
    numbers.forEach {
        for i in 0..<$0 {
            print("\(i+1) : \(string)")
        }
    }
}

myFunc(numbers: 1,2,3, string: "hello")
//1 : hello
//1 : hello
//2 : hello
//1 : hello
//2 : hello
//3 : hello


*/

// 16, 初始化顺序
// 在某个子类中，初始化方法里的语句的顺序并不是随意的，
// 我们需要保证在当前子类实例的成员初始化完成后才能调用父类的初始化方法

class Cat {
    var name : String
    init() {
        name = "cat"
    }
}

class Tiger : Cat {
    let power : Int
    override init() {
        power = 10
//        super.init()            //  如果不改变父类的属性，可以不写这一行 + 下一行
//        name = "tiger"          //
    }
}

//    一般来说， 子类的初始化顺序是：
//    1, 设置子类需要自己初始化的参数， power = 10
//    2, 调用父类的相应的初始化方法，super.init()
//    3, 对父类中需要改变的成员进行设定 name = "tiger"
//    其中第三步是更具情况决定的，如果我们在子类中不需要对父类成员作出改变，就不存在第三步



// Designated, Convenience 和 Required
// 指定构造     便利构造        必须
/*
class ClassA{
    let numA : Int
    required init(num: Int) {        // 指定构造函数
        numA = num
    }
    
    convenience init(bigNum: Bool){ // 便利构造
        self.init(num: bigNum ? 10000 : 1)
    }
}
class ClassB: ClassA {
    var numB: Int
    required init(num: Int){            // 子类必须实现
        numB = num + 1
        super.init(num: num)
    }
    
//    convenience init(num: Int, bigNum: Bool){
//        numB = bigNum ? 10000 : 1
//        self.init(num: num)
//    }
    
}

//    初始化方法永远遵循以下两个原则
//    1， 初始化路径必须保证完全初始化，这可以通过调用本类型的
//      designated初始化方法来得到保证
//    2， 子类的designated初始化方法必须调用父类的designated方法，
//      以保证父类也完全初始化
//
//


*/

// 17, 初始化返回nil
//  convenience init?(string URLString: String)
/*
extension Int {
    init?(fromString: String){
        self = 0
        var digit = fromString.count - 1
        for c in fromString {
            var numb = 0
            if let n = Int(String(c)){
                numb = n
            }else {
                switch c {
                case "一": numb = 1
                case "二": numb = 2
                case "三": numb = 3
                case "四": numb = 4
                case "五": numb = 5
                case "六": numb = 6
                case "七": numb = 7
                case "八": numb = 8
                case "九": numb = 9
                case "零": numb = 0
                default: return nil
                }
            }
            self = self + numb * Int(pow(10.0, Double(digit)))
            digit = digit - 1
        }
    }
}

print(Int(fromString: "12"))
print(Int(fromString: "三九零"))
print(Int(fromString: "吃了吗"))

*/

// 18 static 和 class

// static 可以用在 struct enum 中表示类型作用域
// class 用在  class 中
// class 中使用 class关键字开头的属性会报错
// 任何时候使用 static 都是可以的

// 19 多类型和容器
/*
// 协议
let mixed : [CustomStringConvertible] = [1, "two", 3]

mixed.forEach { (obj) in
    print(obj.description)
}


// 这种常用的场景，是用 enum可以带值的特点，将类型信息封装到特定的 enum中

enum IntOrString{
    case IntValue(Int)
    case StringValue(String)
}
// 通过这种方法，我们完整的在编译时保留了不同类型的信息
let minxed = [ IntOrString.IntValue(1), IntOrString.StringValue("Two")]

for value in minxed {
    switch value {
    case let .IntValue(i):
        print(i * 2)
    case let .StringValue(s):
        print(s.capitalized)
    }
}
*/



















