//: [Previous](@previous)

import Foundation

class BankAccount {
    var balance: Double = 0.0
    private let lock = NSLock()

    func deposit(amount: Double) {
        lock.lock()
        balance += amount
        lock.unlock()
    }

    func withdraw(amount: Double) {
        lock.lock()
        if amount <= balance {
            balance -= amount
        } else {
            print("Insufficient funds!")
        }
        lock.unlock()
    }
}

let account = BankAccount()

let group = DispatchGroup()

DispatchQueue.concurrentPerform(iterations: 100) { _ in
    group.enter()
    DispatchQueue.global().async {
        account.deposit(amount: 10.0)
        group.leave()
    }

    group.enter()
    DispatchQueue.global().async {
        account.withdraw(amount: 5.0)
        group.leave()
    }
}

group.wait()

print("Final balance: \(account.balance)")

//: [Next](@next)
