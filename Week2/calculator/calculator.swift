#!/usr/bin/swift

import Foundation

enum OperationType: String, Equatable {
    case divide = "/"
    case multiply = "*"
    case substract = "-"
    case add = "+"
    case modulo = "%"
    case quit = "q"
}

class Calculator {
    var selectedOperation: OperationType?
    var firstNumber: Double?
    var secondNumber: Double?
    
    func Start() {
        instructionMessage()
        operationInput(value: readLine() ?? "")
        inputValueMessage()
        numberInput(value: readLine() ?? "")
    }
    
    func welcomeMessage() {
        print("Welcome to Command Line Calculator! Press `q` to quit at anytime.")
    }
    
    func instructionMessage() {
        print("What operation would you like to perform (/, *, -, +, %)?")
    }
    
    func inputValueMessage() {
        if firstNumber == nil {
            print("Please enter the first number.")
        } else {
            print("Please enter the second number.")
        }
    }
    
    private func displayAnswer(value: Double) {
        print("Answer: \(value)")
    }
    
    func operationInput(value: String) {
        let operation = OperationType(rawValue: value)
        switch operation {
        case .divide:
            selectedOperation = .divide
        case .multiply:
            selectedOperation = .multiply
        case .substract:
            selectedOperation = .substract
        case .add:
            selectedOperation = .add
        case .modulo:
            selectedOperation = .modulo
        case .quit:
            selectedOperation = .quit
            exit(1)
        default:
        print("Invalid Operation\n")
        instructionMessage()
        operationInput(value: readLine() ?? "")
        }
    }
    
    func numberInput(value: String) {
        guard let number = Double(value) else {
            if let q = OperationType(rawValue: value) {
                if q == .quit {exit(1) }
            }
            print("Invalid Input")
            inputValueMessage()
            numberInput(value: readLine() ?? "")
            return
        }
        if firstNumber == nil {
            firstNumber = number
            inputValueMessage()
            numberInput(value: readLine() ?? "")
        } else {
            secondNumber = number
            calculateAnswer()
        }
    }
    
    func calculateAnswer() {
        guard let fNumber = firstNumber, let sNumber = secondNumber else {return}
        switch selectedOperation {
        case .divide:
            displayAnswer(value: fNumber / sNumber)
        case .multiply:
            displayAnswer(value: fNumber * sNumber)
        case .substract:
            displayAnswer(value: fNumber - sNumber)
        case .add:
            displayAnswer(value: fNumber + sNumber)
        case .modulo:
            displayAnswer(value: fNumber.truncatingRemainder(dividingBy: sNumber))
        default:
            return
        }
        firstNumber = nil
        secondNumber = nil
        selectedOperation = nil
    }
}

let calculator = Calculator()

calculator.welcomeMessage()

while true {
    calculator.Start()
}








