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

func +*(left: Vector2D, right: Vector2D) -> Double{
    return left.x * right.x + left.y + right.y
}











































