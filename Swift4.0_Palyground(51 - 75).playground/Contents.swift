//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"
print(str)

// 51 COpaquePointer 和C convention
// C / C++ 中的不透明指针对应Swift 中 COpaquePointer指针

// c 中有这样一个函数, 这个函数接受一个callBack,
// 这个 callBack 有两个 int 类型的参数，cFunction返回 callBack的结果
//    int cFunction(int (callBack)(int x, int y)){
//        return callBack(1, 2);
//    }

// 在 swift 中表示
//    let callBack: @convention(c) (Int32, Int32) -> Int32 = {
//        (x, y) -> Int32 in
//        return x + y
//    }
//
//    let result = cFuntion(callBack)
//    print(result)

// 在没有歧义的情况下可以简化成
//    let result = cFunction {
//        (x, y) -> Int32 in
//        return x + y
//    }
//
//    print(result)

// 52 GCD和延时调用

// 开启多线程执行
//    import PlaygroundSupport
//    PlaygroundPage.current.needsIndefiniteExecution = true

//    let workingQueue = DispatchQueue(label: "myQueue")
//
//    workingQueue.async {
//
//        print("... 复杂操作 ")
//
//        DispatchQueue.main.async {
//            print("结束工作， 更新UI")
//        }
//    }

//    let time : TimeInterval = 2.0
//    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//        print("2秒后输出")
//    }
/*

typealias Task = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) -> Task? {
    
    func dispatch_later(block: @escaping ()->()){
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    var closure : (()->Void)? = task
    var result : Task?
    
    let delayedClosure :Task = {
        cancel in
        if let internalClosure = closure {
            if cancel == false {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    
    return result
}

func cancel(_ task : Task?){
    task?(true)
}

let task = delay(2) {
    print("拨打110")
}

cancel(task)

*/

// 53 获取对象类型

/*
let date = NSDate()

let name: AnyClass! = object_getClass(date)

let name1 = type(of: date)

print(name)
print(name1)

*/

// 54 自省
// 向一个对象发出询问，以确定它是不是属于某个类，这就是自省

// [obj1 isKingofClass: [ClassA class]]   // 是否是其或者其子类的实例对象
// [obj1 isMemberofClass: [ClassB class]] // 是否是其的实例对象
// 如果这个对象是继承自NSObject 在 swift 中等价于
// 也可以适用在 非  NSObject 类上
/*
class ClassA : NSObject{}
class ClassB : ClassA {}

let obj1 :NSObject = ClassB()
let obj2 :NSObject = ClassB()

obj1.isKind(of: ClassA.self)    // true
obj2.isMember(of: ClassA.self)  // false


// is 相当于 isKindofClass 检查一个对象是否属于某个类型或者其子类型
// 也可以检查 struct / enum


*/

// 55 KeyPath  和  KVO
/// Swift 适用 KVO 需要将观测的对象标记为 dynamic和 @objc

// Swift 4上
/*
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


// 或者 @objcMembers 对每一个属性都默认加上了一个 @objc
//    @objcMembers MyClass : NSObject {
//        dynamic var date = Date()
//    }

// 控制器中
class AnotherController: UIViewController {
    
    var myObject : MyClass = MyClass()
    var observation : NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // \MyClass.date 用来简化这个属性 keyPath: KeyPath<MyClass, Value>
        
        // 注意： 这里回调如果使用了self， 需要使用 [weak self]
        observation = myObject.observe(\MyClass.date, options: [.new], changeHandler: { [weak self]  (_, change) in
            guard let weakSelf = self else {  return }
            if let newDate = change.newValue {
                print(weakSelf)
                print("日期发生变化：\(newDate)")
            }
        })
        
        // 另外这里如果要改变观察对象，最好也使用 [weak self], 这样会避免在控制器销毁后，回调仍然触发的bug
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.myObject.date = Date()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myObject.date = Date()
    }
    deinit {
        print("\(type(of: self)) deinit")
    }
}


// 这种方法需要在 被观察的类或者属性前加 @objc dynamic， 如果原来的类并不打算加上这些前缀，我们需要新建一个他的子类，重写被观察的属性，加上 @objc dynamic


class ParentClass : NSObject {
    var date = Date()
}

// 如果只观察一个属性
// 重写原来的类的属性，加上 @objc dynamic , 并实现 存储属性的get set 方法
class MyClass : ParentClass {
    @objc dynamic override var date : Date // = Date()
        {
        get {
            return super.date
        }
        set {
            super.date = newValue
        }
    }
}



*/
// 56  局部 scope
//
/*
// 代码隔离
do {
    
}

// 或者使用匿名闭包的方式
let titleLabel : UILabel = {
    let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    // ..
    return lbl
}()
*/

// 57 判等
/*
let str1 = "快乐的"
let str2 = "开心的"
let str3 = "快乐的"

print(str1 == str2) // false
print(str1 == str3) // true


// OC 中的  == 是判断是否是同一块内存地址
// Swift 是 Equatable 协议中的一个方法，可以自己实现，
// 操作符是全局生效的
// Swift 中的 == 对于NSObject类来说，等于 isEqual:方法
// Swift 中的 === 符号用来判断两边是否是同一个引用


*/


// 58 哈希
// 哈希是单向的，对于相等的对象或值，我们可以期待他们拥有相同的哈希，但是反过来不一定成立。
// 某些对象的哈希值有有可能随着系统环境或者时间的变化而变化


// 59 类簇
// 对于Swift中类簇构建，一种有效的方法是使用工厂方法进行，
// 在基类中，根据传入的参数不同，返回生成的不同的子类

// 60 调用 C动态库
// Swift 调用 C 动态库，需要借助 OC桥接

// 61 输出格式化
// Swift 输出保留几位小数
/*
let b = 1.23423
let format = String(format:"%.2f", b)
print("double: \(format)")  //  double: 1.23

extension Double {
    func format(_ f: String) -> String{
        return String(format: "%\(f)f", self)
    }
}

print("double:\(b.format(".2"))")

*/

// 62 Options
// OC 中的 NS_ENUM -> Swift enum
// OC 中的 NS_OPTIONS -> Swift struct static var ..{ get }

//    UIView.animate(withDuration: 0.3,
//                   delay: 0.0,
//                   usingSpringWithDamping: 0.0,
//                   initialSpringVelocity: 0.0,
//                   options: [.curveEaseIn, .allowUserInteraction],
//                   // 如果不需要 使用 []
//                   animations: {},
//                   completion: nil)

/*
struct MyOption : OptionSet {
    let rawValue: UInt
    static let none = MyOption(rawValue: 0)
    static let option1 = MyOption(rawValue: 1)
    static let option2 = MyOption(rawValue: 1 << 1)
    static let option3 = MyOption(rawValue: 1 << 2)
    // ..
}
*/

// 63 数组 enumerate
/*
//OC 的方法
//    let arr : NSArray = [1,2,3,4]
//    var result = 0
//    arr.enumerateObjects { (num, index, stop) in
//        result += num as! Int
//        if index == 2 {
//            stop.pointee = true
//        }
//    }

// Swift 中的方法
var result = 0
for (idx, num) in [1,2,3,4].enumerated() {
    result += num
    if result == 2 {
        break
    }
}

*/

// 64 类型编码 @encode
// swift中不能使用 @encode关键字获取类型编码了
// 某些 API 建议使用  NSValue的方法来获取
/*
let int : Int = 0
let float : Float = 0.0
let double : Double = 0.0

let intNumber : NSNumber = int as NSNumber
let floatNumber : NSNumber = float as NSNumber
let doubleNumber : NSNumber = double as NSNumber


print(String(validatingUTF8: intNumber.objCType))
print(String(validatingUTF8: floatNumber.objCType))
print(String(validatingUTF8: doubleNumber.objCType))
//Optional("q")
//Optional("f")
//Optional("d")


let p = NSValue(cgPoint:CGPoint(x: 3, y: 4))
print(String(validatingUTF8: p.objCType))
//Optional("{CGPoint=dd}")

// 例如， 在存储 NSUserDefaluts 存储不同类型的数字，可以在存储的时候 把类型信息一起存储，在取出的时候方便映射成存储时的类型

*/


// 65 C代码调用和 @asmname
// asmname 在swift2.2 改名为 _silgen_name
// 原来Swift中 引用 C 代码需要在 桥接文件中导入 C.h 头文件

// 在swift中
// 将 C 的 test 方法映射成 Swift的 c_test方法
//@asmname("testFunc") func c_test(a : Int32) -> Int32
//
//func method(input: Int32) {
//    let result = c_test(a: input)       // 这是是从C代码中映射过来的
//    print(result)
//}


//    在 C.h 中
//    int cMethod(int value);

//    在swift中
//    @_silgen_name("cMethod")  /// 对应的C文件中的方法，下面为生成Swift的方法签名
//    func c_test(value: Int32) -> Int32


// 66 delegate
// 声明协议 如果需要在 class 中声明 delegate变量实现这个协议，需要对协议进行处理
/*
// 第一种做法
@objc protocol MyClassDelegate { func method() }

// 第二种做法,这种更好,方便兼容。 指定为class 来实现
protocol MyAnoClassDelegate : class { func method() }

*/

// 67 Associated Object
// 关联对象
/*
class MyClass{}

// MyClassExtension.swift
private var key: Void?

extension MyClass {
    var title: String? {
        get{
            return objc_getAssociatedObject(self, &key) as? String
        }
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

*/

// 题外话，  Swift 中实现“交换方法”
// 见Git https://github.com/dingfude2008/Swift_Method_Swizzling.git

// 68 Lock
// OC 中 @synchronized互斥锁 其实在底层调用的是 objc_sync_enter 和 objc_sync_exit
// Swift 中直接使用
/*
func myMethod(anObj: AnyObject!){
    objc_sync_enter(anObj)
    
    // 内容
    
    objc_sync_exit(anObj)
}

// 为了方便, 封装成闭包
func synchronized(_ lock: AnyObject, closure: ()->()){
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

// 使用的时候
func myMethod1(anObj: AnyObject!){
    synchronized(anObj){
        // 内容
    }
}

*/

// 69 Toll-Free Bridging 和 Unmanaged
// CF 框架在Swift中的运用
/*
import AudioToolbox

let fileURL = NSURL(string: "SomeURL")
var theSoundID : SystemSoundID = 0

AudioServicesCreateSystemSoundID(fileURL!, &theSoundID)

*/

// Swift 与开发环境及一些实践
// 70 Swift 命令行工具

// 终端 输入 swift 进入 REPL 环境
// swiftc 进行编译

// 71 随机数的生成

// 返回的是 UInt32 在32位机上有一半几率进行 Int转换事越界
//arc4random()

//    let diceFaceCount: UInt32 = 6
//    let randomRoll = Int(arc4random_uniform(diceFaceCount)) + 1
//    print(randomRoll)
/*
let range = Range<Int>(1..<6)
//print(range.upperBound)
//print(range.lowerBound)

func random(in range: Range<Int>) -> Int{
    let count = UInt32(range.upperBound - range.lowerBound)
    return Int(arc4random_uniform(count)) + range.lowerBound
}

for _ in 0...5{
    let range = Range<Int>(1...100)
    print(random(in: range))
}

*/


// 72 print 和 debugPring

//
//CustomStringConvertible
//CustomDebugStringConvertible


// 73 错误和异常处理
/*
// 这种throws 机制仅仅适用于同步机制，如果是是异步才知道结果的话，是不适用的
enum LoginError : Error {
    case UserNotFound, UserPasswordNotMatch
}

func login(user: String, password: String) throws {
    
    //
    let users = ["ab":"22"]
    
    if !users.keys.contains(user) {
        throw LoginError.UserNotFound
    }
    
    if users[user] != password {
        throw LoginError.UserPasswordNotMatch
    }
    
    print("Login successful")
}


do {
    try login(user: "ab", password: "22")
} catch LoginError.UserNotFound {
    print("UserNotFound")
} catch LoginError.UserPasswordNotMatch {
    print("UserPasswordNotMatch")
}

// 结合 try? 使用
enum E : Error {
    case Negative
}

func methodThrowWhenPassingNegative(number: Int) throws -> Int{
    if number < 0 {
        throw E.Negative
    }
    return number
}

// 使用 try? 表示如果产生错误，我们不关心
// 产生错误的时候，会返回一个 nil
// 注意 在一个 throw方法里，我们永远不要返回一个 Optional值
if let num = try? methodThrowWhenPassingNegative(number: 100) {
    print(type(of: num))
}else {
    print("failed")
}

// rethrows  一般用于 在参数中包含了一个 可以 throws的方法

func methodThrows(num: Int) throws {
    if num < 0 {
        print("Throwing!")
        throw E.Negative
    }
    print("AAA")
}

func methodRethrows(num: Int, f: Int throw -> ()) rethrows {
    try f(num)
}

// 使用时
do {
    try methodRethrows(num: 1, f: methodThrows)
} catch _ {
    
}

// rethrows的方法可以用来重载那些被标为 throws 的方法或者参数


*/


// 74 断言
// 断言的另一个特性是他是一个开发时的特性，只有在debug时有效

// 如果我们需要在debug中禁用断言，或者在release中生效
// Build Setting -> Swift Compiler - Custom Flags 中 Other Swift Flags中添加
// -assert-config Debug 来强制启用断言， 或者 -assert-config Release 来强制禁用断言


// 75 fatalError
// 产生致命错误，终止程序

//    let array = [1,2,3]
//    array[100]
// 报错 fatal error: Array index out of range

//    @noreturn func fatalError(@autoclosure message:() -> String = default,
//        file:StaticString = defalut,
//        line: UInt = defalut)

// @noreturn 表示如果在一个需要返回值的方法里调用了这个方法，就不需要再有返回值了
// 例如

//    enum MyEnum {
//        case Value1,Value2
//    }
//
//    func check(someValue: MyEnum) -> String {
//        switch someValue {
//        case .Value1:
//            return "OK"
//        case .Value2:
//            return "MayBe OK"
//        default:
//            // 这个分支没有返回 String, 也能编译通过
//            fatalError("Show not show")
//        }
//    }

// 抽象类型和抽象函数的实现
// 在父类中强制抛出错误，来让子类重写这个方法

class MyClass {
    func methodMustBeImplementedSubClass(){
        fatalError("子类必须重写这个方法")
    }
}

class SonClass: MyClass {
    override func methodMustBeImplementedSubClass() {
        print("子类实现方法")
    }
}

class AnotherSonClass: MyClass{
    
}

SonClass().methodMustBeImplementedSubClass()

//Fatal error: 子类必须重写这个方法: file Swift4.0_Palyground(51 - 75).playground, line 618
//AnotherSonClass().methodMustBeImplementedSubClass()


// 对于我们不希望别人随意调用，但是又不得不去实现的防范，我们都应该使用 fatalError来避免任何可能的误会。比如父类表明了某个 init方法是required的，但是子类永远不会使用到这个方法来初始化，就可以使用类似的方法。比如
//    required init(coder: NSCoder){
//        fatalError("NSCoding not supported")
//    }






















