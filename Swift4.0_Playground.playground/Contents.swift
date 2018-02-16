//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

// 1 柯里化始终量产相似方法的好方法
func addTo( _ adder: Int) -> (Int)-> Int {
    return {
        num in
        return num + adder
    }
}

let add10 = addTo(10)

let number = add10(5)

// 2 将protocol 的方法声明为 mutating(突变)
// 当协议的继承者是struct 或者 enum时， mutating关键字修饰方法是为了能在该方法中修改 struct 或是enum的变量
// 如果不适用 mutating关键字，继承此协议的struct或者enum在此方法中更改属性时，会报错说不能改变结构体成员
//

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

// 3 Sequence 序列
/*
    Swift的for...in 可以用在所有实现了了sequence的类型上，
    IntertoProtocol协议
 
    currentIndex = 0
    next() -> T?
 */


// 多元组 （Tuple）
func swapMe2<T>(a : inout T, b: inout T){
    (a, b) = (b, a)
}

/*
    元组是
    (,)
 */

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









































