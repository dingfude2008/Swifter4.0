//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"
print(str)

// 76 代码组织和 Framework
// Swift 的解释和运行环境还没有非常稳定。

// 77 安全的资源资质方式
// R.swift

// 78 Playground 延时运行
/*
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
// 在顶层代码执行后延时30秒


*/

// 79 Playground 与项目协作
// 条件
// 1，Playground 必须加入的项目中，
//   File -> New -> File 然后里面选择 Playground
// 2，想要使用的代码必须是通过 Cocoa(Touch)Framework以一个单独的target的方法进行组织的
// 3， 编译记过的位置需要保持默认位置 Xcode Locations 里的 Derived Data 保持默认
// 4， 针对 64位进行编译

// 然后就可以，  import module 的形式引用了

// 80 Playground 可视化开发

import PlaygroundSupport

//    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
//    label.backgroundColor = UIColor.white
//    label.font = UIFont.systemFont(ofSize: 32)
//    label.textAlignment = .center
//    label.text = "测试可视化"
//    label.layer.borderWidth = 1
//    label.layer.borderColor = UIColor.red.cgColor
//
//    // var liveView: PlaygroundLiveViewable? { get set }
//    PlaygroundPage.current.liveView = label

// 也可以赋值一个 UIViewController
/*

class ViewController : UITableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension ViewController {
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10.0
    }
    
}

extension ViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Select: \(indexPath.row)")
    }
}

let vc = ViewController()
PlaygroundPage.current.liveView = vc

// 不是很容易控制它

*/


// 81 数学和数字
/*
// Double
Double.infinity     // 无穷大
Double.nan          // 不是数字，表示运算错误

let a = 0.0 / 0.0
print(a) // nan

let b = sqrt(-1.0)
print(b) // nan

let c = 0.0 * Double.infinity
print(c) // nan

// 注意， nan != nan

print(Double.nan == Double.nan)  // false

print(Double.nan.isNaN)     // true

*/


// 82 JSon 和 Codable
/*
let jsonString = "{\"menu\":{\"id\":\"file\",\"value\":\"File\",\"popup\":{\"menuitem\":[{\"value\":\"New\", \"onclick\":\"CreateNewDoc()\"},{\"value\":\"Open\", \"onclick\":\"OpenDoc()\"},{\"value\":\"Close\", \"onclick\":\"CloseDoc()\"}]}}}"

//    {"menu":{
//        "id":"file",
//        "value":"File",
//        "popup":{
//            "menuitem":[
//            {"value":"New", "onclick":"CreateNewDoc()"},
//            {"value":"Open", "onclick":"OpenDoc()"},
//            {"value":"Close", "onclick":"CloseDoc()"}
//            ]
//        }
//        }
//    }


let data : Data? = jsonString.data(using: .utf8, allowLossyConversion: true)
let json : Any = try JSONSerialization.jsonObject(with: data!, options: [])
print(json)

// string -> dic/array

struct Obj: Codable {
    let menu : Menu
    struct Menu: Codable{
        let id : String
        let value : String
        let popup: Popup
    }
    struct Popup: Codable {
        let menuItem: [MenuItem]
        enum CodingKeys : String, CodingKey {
            case menuItem = "menuitem"
        }
    }
    struct MenuItem :Codable {
        let value: String
        let onClick: String
        
        enum CodingKeys: String, CodingKey {
            case value
            case onClick = "onclick"
        }
    }
}

do {
    if let data1 = jsonString.data(using: .utf8, allowLossyConversion: true) {
        let obj = try JSONDecoder().decode(Obj.self, from: data1)
        let value = obj.menu.popup.menuItem[0].value
        print(value) // New
    }
} catch {
    print("出错了")
}


*/

// 83 NSNull
/*
let jsonValue : AnyObject = NSNull()

if let string = jsonValue as? String{
    print("")
}else {
    print("不能解析")
}
*/
// 84 文档注释
/*
// Alt + cmd + /

/// <#Description#>
///
/// - Parameter num: <#num description#>
/// - Returns: <#return value description#>
func abc(num : Int) -> Int{
    return 1
}

*/

// 85 性能考虑
// 如果遇到性能敏感和关键的代码部分，我们最好避免使用 OC 和 NSObject的子类，


// 86 Log 输出

//    #file     String  包含这个符号的文件的路径
//    #line     Int     符号出现的行号
//    #column   Int     符号出现的列号
//    #function String  包含这个符号的方法名字

/*
func printLog<T>(_ message: T,
                 file: String = #file,
                 method:String = #function,
                 line: Int = #line){
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line),\(method):\(message)]")
    #endif
}

printLog(123)

*/

// 87 溢出

// 编译报错
//    var max = Int.max
//    max = max + 1


// 溢出加法 &+
// 溢出减法 &-
// 溢出乘法 &*
// 溢出除法 &/
// 溢出球模 &%
/*
var max = Int.max
max = max &+ 1
print(max) // -9223372036854775808

*/

// 88 宏定义
// swift 中没有宏定义了

// 原来的宏定义 Apple 建议改为 let  或者  get 属性进行替换

// 89 属性访问控制
// private -> fileprivate -> internal -> public -> open
// 默认 internal

//  public // 可以调用
//  open   // publi + 可以继承 + 重写

// 只读属性
//    private(set) var name : String?

// 属性的访问权要低于他所属于的类

// 90 Swift中的测试
// 在测试test module中，调用主module 前 加上 @testalbe 这是方便跨module测试代码

// 91 CoreData

// OC 中的 @dynamic 是表示我们自己实现属性的 getter 和 setter 方法
// Swift 的 dynamic 表示 KVO 观察属性 要配合 @objc

// Swift CoreData

import CoreData

class MyModel: NSManagedObject {
    // 动态处理代码。
    // 这是编译器边不在纠结没有初始化方法实现title 的初始化了
    @NSManaged var title : String
}

// 另外通过数据模型图创建Entity时要特别注意在 Class 中指定类型名时必须加上app的 module名称
// 才能保证在代码中做类型转换时不发生错误
// Class： MyApp.MyModel

//  92 闭包歧义
/*
extension Int {
//    func times(f: (Int)->()) {
//        print("Int")
//        for i in 1...self{
//            f(i)
//        }
//    }
    func times(f: ()->()) {
        print("Void")
        for _ in 1...self{
            f()
        }
    }
}

//3.times { (i:Int) in
//    print(i)
//}

3.times {
//    print("2")
}
print("2")

typealias Void = ()

// Void 其实是一个不包含任何元素的空元组

*/

// 93 泛型扩展
// 泛型类型在定义时就引入了类型标志，比如
// public struct Array<Element>: ....
// 我们可以在extension 中使用 Element类型，当然也可以再次声明其他的泛型类型标志

// 94 兼容性
// 如果我们使用OC开发项目，用到de扩展中使用到了Swift, 需要把
// Build Options 中 Embedded Content Contains Swift Code设置为YES，以去哦表Swift的运行宝被打包进APP中

// 95 列举enum类型
/*
enum Suit : String {
    case spades = "黑桃"
    case hearts = "红桃"
    case clubs = "梅花"
    case diamonds = "方片"
}

enum Rank: Int, CustomStringConvertible {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    var description: String {
        switch self {
        case .ace:
            return "A"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        default:
            return String(self.rawValue)
        }
    }
}

// 声明一个协议
protocol EnumerableEnum {
    static var allValues: [Self]{get}
}

extension Suit : EnumerableEnum {
    static var allValues: [Suit]{
        return [ .spades, .hearts, .clubs, .diamonds]
    }
}

extension Rank : EnumerableEnum {
    static var allValues: [Rank]{
        return [ .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king]
    }
}

// 这样我们就可以快乐的遍历啦
Suit.allValues.forEach { (suit) in
    Rank.allValues.forEach({ (rank) in
        print("\(suit.rawValue)\(rank)")
    })
}

*/

// 96 尾递归

func sum(_ n :UInt) -> UInt {
    if n == 0 {
        return 0
    }
    return n + sum(n - 1)
}

// 上面的代码如果调用的数字大一点，就会导致崩溃，因为栈空间被耗尽

func tailSum(_ n : UInt) -> UInt {
    func sumInternal(_ n: UInt, current: UInt) -> UInt{
        if n == 0 {
            return current
        }else {
            return sumInternal(n - 1, current: current + n)
        }
    }
    return sumInternal(n, current: 0)
}

//tailSum(1000000)
// 在 debug 仍然会崩溃，在 release 下不会，release 会优化尾递归



















