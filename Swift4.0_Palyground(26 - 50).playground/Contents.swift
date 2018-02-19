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

// 32 多重 Optional













