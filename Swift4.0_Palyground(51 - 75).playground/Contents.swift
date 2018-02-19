//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"


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

import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class MyClass : NSObject {
    @objc dynamic var date = Date()
}

//class AnotherClass: NSObject {
//    var myObject : MyClass!
//    var observation : NSKeyValueObservation?
//    
//    override init() {
//        super.init()
//        myObject = MyClass()
//        
//        print("初始化时， 当前日期：\(myObject.date)")
//        
//        let keyPath = \MyClass.data
//        
//        observation = myObject.observe(\MyClass.date, options: [.new], changeHandler: { (_, change) in
//            if let newData = change.newValue {
//                print("日期发生变化")
//            }
//        })
//        
//        observation = myObject.observe(<#T##keyPath: KeyPath<MyClass, Value>##KeyPath<MyClass, Value>#>, changeHandler: <#T##(MyClass, NSKeyValueObservedChange<Value>) -> Void#>)
//        
//        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            self.myObject.date = Date()
//        }
//    }
//    
//    deinit {
//        
//    }
//}






















