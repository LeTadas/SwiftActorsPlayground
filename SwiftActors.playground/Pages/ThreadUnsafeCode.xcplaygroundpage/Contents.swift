//: [Previous](@previous)

import Foundation

class BankAccount {
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
