//: [Previous](@previous)

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

//: [Next](@next)
