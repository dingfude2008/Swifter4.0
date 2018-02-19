//: Playground - noun: a place where people can play

import UIKit
import Foundation


print("Hello world")

// 26 属性观察

/*
class MyClass {
    // 存储型属性
    var date : NSDate {
        willSet {
            print("即将将日期从 \(date)设定到\(newValue)")
        }
        didSet {
            print("已经将日期从\(oldValue)设定到\(date)")
        }
    }
    
    var index : Int = 0
    
    // 计算型属性
    var age : Int {
        get {
//            Attempting to access 'age' within its own getter
//            print("\(age)")
            print("get")
            return self.index
        }
        set {
            print("set")
            print("\(newValue)")
//            print("\(age)")
//           The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.
            
            self.index += 1
        }
    }
    
    init() {
        date = NSDate()
    }
}
let foo = MyClass()
foo.date = foo.date.addingTimeInterval(10086)



// 初始化方法的设定和willSet和didSet中对属性的再次设定不会再次触发属性观察的调用
// 存储属性将会在内存中实际分配地址对属性进行存储，计算属性则不包括存储

// 存储型属性中的使用 willSet 和 didSet,
// 计算型属性中使用  set      和  get

// willSet 中可以使用 当前属性 + newValue
// didSet  中可以使用 当前属性 + oldValue
// set 中可以使用 newValue   不能使用 当前属性
// get 中不能使用 newValue，也不能使用 当前属性

let foo1 = MyClass()
print(foo1.age)
foo1.age = 10

// 另外如果我们无法一个类，又想要通过属性观察做一些事情，可能就需要子类化这个类
// 并且重写它的属性，重写的属性并不知道父类属性的具体实现情况，而只是从父类属性中继承了
// 名字和类型，因此子类的重载属性中我们是可以对父类属性任意的添加属性观察，
// 而不用管父类中到底是存储属性还是计算性属性
// 比如

class MySonClass : MyClass {
    // 父类中是存储属性，这里重写为计算属性
//    override var date: NSDate {
//        get {
//            print("get")
//            return NSDate(timeIntervalSince1970: TimeInterval(self.index))
//        }
//        set{
//            print("set")
//            self.index = 999
//        }
//    }
    
    override var age: Int {
        willSet {
            print("即将将age从 \(age)设定到\(newValue)")
        }
        didSet {
            print("已经将age从\(oldValue)设定到\(age)")
        }
    }
}
print("------------------------------")
let foo2 = MySonClass()
//foo2.date = foo.date.addingTimeInterval(10086)
//print(foo2.age)
foo2.age = 88
// 打印
//    get
//    get
//    即将将age从 0设定到88
//    set
//    88
//    get
//    已经将age从0设定到1

*/

// 28 final 关键字
// 最终的， 可以用在 class func var 前面进行修饰，
// 表示不允许对该内容进行继承或者重写操作，和 c#的 sealed相同
//    使用场景
//
//    1， 权限控制
//    2， 类或者方法的功能确实已经完备了
//    3， 子类继承和修改是一件危险的事情
//    4， 为了父类中某些代码一定会被执行
//    5， 性能考虑
/*
class Parent {
    final func method(){
        print("开始配置")
        // ... 必要的代码
        
        methodImpl()
        
        print("结束配置")
    }
    
    func methodImpl(){
        fatalError("子类必须实现这个方法")
        // 或者也可以给出默认实现
    }
}

class Child: Parent {
    override func methodImpl() {
        // 子类的业务逻辑
    }
}

// 这样无论如何我们如何使用method，都可以保证需要的代码一定运行过，
// 同时又给了子类继承和重写的机会

*/


// 29 lazy 修饰符 和 lazy方法
/*
class ClassA {
    lazy var str : String = {
        let str = "Hello"
        print("只在首次访问时输出")
        return str
    }()
    
    lazy var anotherString = self.str
    lazy var thirdString = {
        return self.str + "3333"
    }()
}

let a = ClassA()
//print(a.str)
print(a.thirdString)
a.thirdString = "111"
print(a.thirdString)


// lazy 延时方法
// 配合 map 或者是 filter这类接受闭包并运行的方法一起，让整个行为变成延时进行

//    let data = 1...3
//    let result = data.map { (i: Int) -> Int in
//        print("正在处理:\(i)")
//        return i * 2
//    }
//    print("准备访问结果")
//    for i in result {
//        print("操作后结果为:\(i)")
//    }
//    print("操作完毕")
//    正在处理:1
//    正在处理:2
//    正在处理:3
//    准备访问结果
//    操作后结果为:2
//    操作后结果为:4
//    操作后结果为:6
//    操作完毕

let data = 1...3
let result = data.lazy.map { (i: Int) -> Int in
    print("正在处理:\(i)")
    return i * 2
}
print("准备访问结果")
for i in result {
    print("操作后结果为:\(i)")
}
print("操作完毕")

//    准备访问结果
//    正在处理:1
//    操作后结果为:2
//    正在处理:2
//    操作后结果为:4
//    正在处理:3
//    操作后结果为:6
//    操作完毕

// 对于那些不需要完全运行，可能提前退出的情况，使用lazy进行优化，效果非常明显

*/

// 30 Reflection 和 Mirror
// 反射 和 镜像

// OC的动态运行时比反射还要灵活和强大
/*
struct Person {
    let name : String
    let age : Int
}

class Pet {
    var name : String?
    var age : Int = 0
}

let xiaoming = Person(name: "XiaoMing", age: 16)
let r = Mirror(reflecting: xiaoming)

print("xiaoming是\(r.displayStyle!)") // xiaoming是struct

r.children.forEach { (child) in
    print("属性名称：\(child.label!), 属性值：\(child.value)")
}

//    属性名称：name, 属性值：XiaoMing
//    属性名称：age, 属性值：16


let hali = Pet()
hali.name = "Hali"
hali.age = 3

let rr = Mirror(reflecting: hali)
print("hali是\(rr.displayStyle!)") // xiaoming是class
rr.children.forEach { (child) in
    print("属性名称：\(child.label!), 属性值：\(child.value), \(type(of: child.value))")
}

//    属性名称：name, 属性值：Optional("Hali"), Optional<String>
//    属性名称：age, 属性值：3, Int


// dump 方法是通过获取一个对象的镜像并进行标准输出的方式将其输出出来
//dump(hali)
//    ▿ __lldb_expr_71.Pet #0
//        ▿ name: Optional("Hali")
//        - some: "Hali"
//        - age: 3


func valueFrom(_ object: Any, key: String) -> Any? {
    let mirror = Mirror(reflecting: object)
    for child in mirror.children {
        let (targetKey, targetMirror) = (child.label, child.value)
        if key == targetKey {
            return targetMirror
        }
    }
    return nil
}

if let name = valueFrom(xiaoming, key: "name") as? String {
    print("通过key得到的值:\(name)")
}


class Dog : NSObject {
    var name : String?
    var age : Int = 0
}

let dog = Dog()
dog.name = "ddd"

// 使用 KVC 获取属性值的时候，必须要保证获取的属性设置了 @objc 关键字，不然报错
// dog.value(forKey: "name")
// @objc var name : String?

//let dogDame = dog.value(forKey: "name")
//print(dogDame)


*/

// 31 隐式解包 Optional
// 在声明的时候，我们可以通过在类型后面加上一个 ！
// 这个语法糖告诉编译器，我们需要一个可以隐式解包的 Optional 值

// 注意： 隐式解包不意味着： ”这个变量不会为nil, 你可以放心使用“
// 这是一种简单但是危险的使用方式
/*
class MyClass {
    func method() {}
}

var maybeObject: MyClass!

//  Fatal error: Unexpectedly found nil while unwrapping an Optional value
// maybeObject.method()

guard let maybeObject = maybeObject else {
    return
}

maybeObject.method()


// xib 拉线会生成 隐式解包
// @IBOutlet weak var btn: UIButton!


*/
// 32 多重 Optional
/*
var string : String? = "string"
var anotherthing : String?? = string

// Expression implicitly coerced from 'String?' to Any
print(string)           // Optional("string")

// Expression implicitly coerced from 'String??' to Any
print(anotherthing)     // Optional(Optional("string"))


anotherthing = "string"

var aNil : String?? = nil

var anotherlNil : String?? = aNil
var literalNil  : String?? = nil

let aa = anotherthing == nil
let bb = literalNil   == nil

print(aa)            // false
print(bb)            // true

// 需要注意的是，如果直接用 po 命令打印 Optional值的话， lldb会将要打印的Optional进行展开
// 如果直接  po anotherthing   po literalNil 打印的都是 nil
// 我们可以使用 ”frv -R + 变量“ 来打印出变量的未加工时的信息


*/

// 33 Optional Map

/*

let num: Int? = 3

//   3?  ->  (* 2)  -> 6?
let result1 = num.map{ $0 * 2 }

*/

// 34 Protocol Extension
// 也就是说，protocol extension 为 protocol中定义的方法提供了一个默认的实现
/*
protocol MyProtocol {
    func method()
}

extension MyProtocol {
    func method(){
        print("Called in MyProtocol extension")
    }
    
    func method2(){
        print("method2 Called in MyProtocol extension")
    }
    
}

struct MyStruct : MyProtocol {
    func method(){
        print("Called in MyStruct")
    }
    
    func method2(){
        print("method2 Called in MyStruct")
    }
}

// 如果本身没有实现这个方法，就调用协议扩展中的默认实现
// 如果本事实现了这个方法，就调用自己实现的
MyStruct().method()

// 如果，协议扩展中添加了原来协议中没有的方法，


let myStruct = MyStruct()
myStruct.method2() // method2 Called in MyStruct

let myStruct2 = myStruct as MyProtocol
myStruct2.method2() // method2 Called in MyProtocol extension

// 会出现一个对象上调动同一个方法，会出现不同的实现

//    总结：
//
//    --> 如果类型推断得到的类型是实际的类型，
//        那么类型中的实现将会被调用，如果类型中没有实现的话，那么协议扩展中的默认实现将会被调用
//
//    --> 如果类型推断得到的是协议，而不是实际的类型
//        1，并且方法在协议中进行了定义，那么类型中的实现将被调用，如果类型中没有实现，那么协议扩展中的
//         方法默认实现将会被调用
//        2， 否则（也就是方法没有在协议中定义），扩展中的实现将会被调用
*/

// 35 where 和模式匹配
// 在 switch 语句中
/*
let name = ["王小二", "张三",  "李四",  "王小三"]
name.forEach {
    switch $0 {
    case let x where x.hasPrefix("王"):
        print("\(x)是作者")
    default:
        print("你好：\($0)")
    }
}

//    王小二是作者
//    你好：张三
//    你好：李四
//    王小三是作者


// 在 for 语句中

let num : [Int?] = [48, 88, nil]
let n = num.flatMap{ $0 }
//n.forEach {
//    print($0)
//}
//    48
//    88
for score in n where score > 60 {
    print("及格了:\(score)")
}
//
//及格了:88

num.forEach{
    if let score = $0, score > 60 {
        print("及格了:\(score)")
    }else {
        print("不及格")
    }
}


// 另外， 在泛型中想要对方法的类型进行限定的时候，也使用where
//    public func !=<T: RawRepresentable
//        where T.RawValue : Equatable>(lhs: T, rhs:T) -> T

// 协议扩展中，希望一个协议扩展的默认实现只在某些特定的条件下适用，

    extension Array where Element : Comparable {
        public func sorted() -> [Self.Iterator.Element]
    }

//    extension Sequence where Self.Iterator.Element: Comparable {
//        public func sorted() -> [Self.Iterator.Element]
//    }

let sortableArray : [Int] = [4, 1, 0, 3]
let unsortableArray : [Any?] = ["Hello", 4, nil]

sortableArray.sorted()

// 下面的编译报错
unsortableArray.sorted()


*/


// 36 indirect 和 嵌套 enum
/*
// 单向链表
class Node<T> {
    let value : T?
    let next: Node<T>?
    init(value : T?, next: Node<T>?){
        self.value = value
        self.next = next
    }
}

let list = Node(value: 1,
                next: Node(value: 2,
                           next: Node(value: 3,
                                      next: Node(value: 4, next: nil))))

// 使用 enum 来定义链表
// indirect 用在非class引用类型的自身嵌套上，提示编译器不要直接在值类型中直接嵌套
indirect enum LinkedList<Element: Comparable>{
    case empty
    case node(Element, LinkedList<Element>)
}

let linkedList = LinkedList.node(1, .node(2, .node(3, .node(4, .empty))))

*/


// 从 OC/C  -> Swift
// 37 Selector
/*
class AAA {
    
    // @objc 关键字，将 Swift 方法暴露给 OC 使用
    @objc func turn(by angle: Int, speed: Float) { }
    @objc func turn(){ }

    func test(){
        // 编译出错
        let method = #selector(turn)
        
        // 正确
        let method = #selector(turn as ()->())
    }
}

*/


// 38 实例方法的动态调用
// 不直接使用实例来调用这个实例上的方法，而是通过类型取出这个类型的某个实例方法的签名，
// 然后再通过传递实例来拿到需要调用的方法
/*
class MyClass {
    func method(number: Int) -> Int{
        return number + 1
    }
    
    class func method(number: Int) -> Int{
        return number + 2
    }
}

// 普通的调用
let object = MyClass()
let result = object.method(number: 1)

// 直接调用这个类的方法 (优先调用同名的类方法)
let f = MyClass.method  // let f: (MyClass) -> (Int) -> Int
let object1 = MyClass()
//let result1 = f(object)(1)

let f1 = MyClass.method
// class func method

let f2 : (Int) -> Int = MyClass.method
// 实例方法

let f3 : (MyClass) -> (Int) -> Int = MyClass.method

let result3 = f3(object1)(3)    // 4
// 等同于 f1
//
*/

// 39 单例
/*
class MyManager {
    static let shared = MyManager()
    private init(){}
}

*/

// 40 条件编译
/*
#if 条件

#elseif 条件

#else

#endif

// Swift内置的几种平台架构的组合

//    os()        macOS, iOS, tvOS, watchOS, Linux, FreeBSD, Windows, Android
//    arch()      x86_64, arm, arm64, i386
//    swift()     >=某个版本

// arch() arm: 32位真机， arm64: 64位真机  i386: 32位模拟器  x86_64: 64位模拟器

// 自定义编译符号在   Build Setting -> Swift Compiler -> Custom Flags -> Other Swift Flags 中加上 -D FREE_VERSION

//这样就可以使用 FREE_VERSION 了

#if FREE_VERSION

#else

#endif

*/

// 41 编译标记

// MARK:
// TODO:
// FIXME:

// 42 @UIApplicationMain

//  @UIApplicationMain作用是将标注的类作为委托，去创建一个 UIApplication并启动整个程序

// 43 @objc 和 dynamic

// swift 使用 OC类，在 桥接文件 {product-module-name}-Bridging-Header.h， 添加OC头文件
// OC 使用 Swift第三方框架， 需要 使用 @import MySwiftKit;
// 同一 module 中，OC 使用Swift, 需要引入  #import "MyApp-Swift.h"

// 在Swift类型文件中，我们可以将需要暴漏给 OC使用的任何地方（类，属性，方法）的声明前加上 @objc 修饰符。注意这个步骤只需要针不是继承自 NSObject的类型。如果 swift写的 class 继承自 NSObject ，Swift 会默认为所有 非private的类和成员加上 @objc

// 添加 @objc 修饰符并不意味着这个方法或者属性会变成动态派发，Swift依然可能会将其优化为静态调用。如果需要和OC一样动态调用时相同的运行时特性的话， 需要加上 dynamic 关键字， 交换方法就是用的这个关键字

// 44 可选协议和协议扩展
// Swift 默认协议中的方法是必须实现的， 如果有的方法确实不需要必须实现，可以
// 1, @objc 关键字
/*
@objc protocol aaaProtocol {
    @objc optional func aaaMethod()
}

// 这样的限制是， 这个协议只能被 class实现，不能被 struct ,enum 实现，并且实现的类还必须标记 @objc 或者整个类继承自 NSObject


// 协议扩展为我们带来了另一种选择， 可以在协议扩展中对不需要必须实现的方法进行模式实现



*/



// 45 内存管理， weak 和 unowned

// 如果 A类中持有了B类的一个属性，那么B类中如果还想持有A类的属性，需要使用 weak 关键字

// weak 和 unowned，如果确认使用时不会被释放，尽量使用unwoned，如果存在被释放的可能，weak

// 使用场景，
//  1, 设置delegate
//  2, 在self属性存储闭包时， 其中拥有对self的引用



// 46 闭包循环引用
    /*
{ [unowned self, weak someOjbect] (number: Int) -> Bool in
    // ..
}


*/

// @autoreleasepool

// 我们可以把内存开销大的代码放入 autoreleasepool 中，来节省开销
/*
autoreleasepool {
    // 。。。。
    
}

*/

// 47 值类型 和 引用类型
// Swift 中，  Int, struct, enum， Array, Dictionary， String 都是值类型
// Swift 中 值类型在没有必要复制的时候，不行进行赋复制操作

//var a = [1,2,3]
//var b = a     // 此时没有发生复制, a和b的内存地址是一样的
//b.append(4)   // 此时，a和b的内存地址不再相同
/*
//print("Hello world11111")
class MyObject{
    var num = 0
}

var myObject = MyObject()
var a = [myObject]
var b = a

b.append(myObject)

myObject.num = 100

print(b[0].num)
print(b[1].num)

// 在需要处理大量数据并且频繁操作（增减）其中元素的时候，选择使用 NSMutableArray 和
  NSMutableDictionary
// 对于容器条目小而且容器本身条目多的情况下， 使用Swift语言內建的Array 和 Dictionary


*/

// 48 String 还是 NSString

// Swift String 是 struct ， NSString是 class
/*
let string : String = "abcde"

let contains = string.contains("b") // true

let nsRange = NSMakeRange(1, 4)

let newString = (string as NSString).replacingCharacters(in: nsRange, with: "1234")

print(string)
print(newString)

//    abcde
//    a1234

*/

// 49 UnsafePointer
/*
func method(_ num: UnsafePointer<CInt>){
    print(num.pointee)
}

var a : CInt = 333

method(&a)

// int -> CInt, bool -> CBool,  char -> CChar
// const Type * --> UnsafePointer
// Type *       --> UnsafeMutablePointer


// 操作指针

let arr = NSArray(object: "aaa")

let cfArr = arr as! CFArray

let valuePoint = CFArrayGetValueAtIndex(cfArr, 0)

let cfString = unsafeBitCast(valuePoint, to: CFString.self)

let string = cfString as! String

print(string)

*/


// 50 C指针内存管理

class MyClass{
    var a : Int = 4
}

var pointer :UnsafeMutablePointer<MyClass>!

// 申请内存
pointer = UnsafeMutablePointer<MyClass>.allocate(capacity: 1)
// 初始化
pointer.initialize(to: MyClass())

print(pointer.pointee.a)

// 清空初始化
pointer.deinitialize()
// 释放内存
pointer.deallocate(capacity: 1)
pointer = nil


