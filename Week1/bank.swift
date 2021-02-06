#!/usr/bin/swift

var balance = 0

print("How much money is in your bank account?")

if let amountentered = readLine() {
    balance = Int(amountentered)!
    doNext()
} else {
    print("You are broke!")
}

func doNext() {
    print("Do you want to deposite or withdraw? D/W")
    if let depositeOrWithdraw = readLine() {
        if depositeOrWithdraw == "D" {
            deposite()
        } else if depositeOrWithdraw == "W" {
            withdraw()
        } else {
            doNext()
        }
    } else {
        doNext()
    }
}

func withdraw() {
    print("How much do you want to withdraw?")
    if let w = readLine() {
        if (balance - Int(w)! > 0) {
            balance = balance - Int(w)!
            print("Your balance is \(balance)")
            doNext()
        } else {
            print("You can not withdraw that amount your balance is \(balance) \n Do you want to deposite money? Y/N ")
            if readLine() == "Y" {
                deposite()
            } else  {
                doNext()
            }
        }
    }
}

func deposite() {
    print("How much do you want to deposite?")
    if let depositeAmount = readLine() {
       balance =  balance + Int(depositeAmount)!
        print("Your balance is \(balance)")
        doNext()
    } else {
        doNext()
    }
}
