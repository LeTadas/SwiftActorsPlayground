import UIKit
import Foundation

//class BankAccount {
//    var balance: Double = 0.0
//
//    func deposit(amount: Double) {
//        balance += amount
//    }
//
//    func withdraw(amount: Double) {
//        if amount <= balance {
//            balance -= amount
//        } else {
//            print("Insufficient funds!")
//        }
//    }
//}
//
//let account = BankAccount()
//let group = DispatchGroup()
//
//DispatchQueue.concurrentPerform(iterations: 100) { _ in
//    group.enter()
//    DispatchQueue.global().async {
//        account.deposit(amount: 10.0)
//        group.leave()
//    }
//
//    group.enter()
//    DispatchQueue.global().async {
//        account.withdraw(amount: 5.0)
//        group.leave()
//    }
//}
//
//group.wait()
//
//print("Final balance: \(account.balance)")

actor BankAccount {
    var balance: Double = 0.0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
        } else {
            print("Insufficient funds!")
        }
    }
}

let account = BankAccount()

Task {
    await withTaskGroup(of: Void.self) { taskGroup in
        for _ in 0..<100 {
            taskGroup.addTask {
                await account.deposit(amount: 10.0)
            }
            
            taskGroup.addTask {
                await account.withdraw(amount: 5.0)
            }
        }
        
        await taskGroup.waitForAll()
    }
    
    let finalBalance = await account.balance
    print("Final balance: \(finalBalance)")
}

//class BankAccount {
//    var balance: Double = 0.0
//    private let lock = NSLock()
//
//    func deposit(amount: Double) {
//        lock.lock()
//        balance += amount
//        lock.unlock()
//    }
//
//    func withdraw(amount: Double) {
//        lock.lock()
//        if amount <= balance {
//            balance -= amount
//        } else {
//            print("Insufficient funds!")
//        }
//        lock.unlock()
//    }
//}
//
//let account = BankAccount()
//
//let group = DispatchGroup()
//
//DispatchQueue.concurrentPerform(iterations: 100) { _ in
//    group.enter()
//    DispatchQueue.global().async {
//        account.deposit(amount: 10.0)
//        group.leave()
//    }
//
//    group.enter()
//    DispatchQueue.global().async {
//        account.withdraw(amount: 5.0)
//        group.leave()
//    }
//}
//
//group.wait()
//
//print("Final balance: \(account.balance)")
