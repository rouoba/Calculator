//
//  ViewController.swift
//  calculator
//
//  Created by Rene Ouoba on 10/19/20.
//

import UIKit

class ViewController: UIViewController {

    
    enum Operation: String {
        case add = "+"
        case substract = "-"
        case multiply = "X"
        case divide = "/"
        case noOperation = ""
    }

    @IBOutlet weak var resultLabel: UILabel!
    var result = 0.0
    var resultString = ""
    var secondNumber = 0.0
    var secondNumberString = ""
    var isCalculating = false
    var operation = Operation.noOperation
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func acPressed(_ sender: UIButton) {
        resetAll()
    }
    
    @IBAction func changeSignPressed(_ sender: UIButton) {
        result *= (-1.0)
        displayResult(myResult: result)
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if let title = sender.currentTitle {
            if !isCalculating {
                if resultLabel.text?.count != 9 {
                    if result == 0.0 {
                        resultString = title
                    } else {
                        resultString += title
                    }
                    resultLabel.text = resultString
                    if resultString != "" {result = Double(resultString)!}
                }
            } else {
                if resultLabel.text?.count != 9 {
                    if secondNumber == 0.0 {
                        secondNumberString = title
                    } else {
                        secondNumberString += title
                    }
                    
                    resultLabel.text = secondNumberString
                    if secondNumberString != "" {secondNumber = Double(secondNumberString)!}
                }
            }
        }
    }
    
    @IBAction func operationIsSelected(_ sender: UIButton) {
        sender.isSelected = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            sender.isSelected = false
        }
        isCalculating = true
        
        if let operationChosen = sender.currentTitle {
            result = calculate(num1: result, num2: secondNumber, operation: operation.rawValue)
            
            displayResult(myResult: result)
            
            switch operationChosen {
            case "+":
                operation = Operation.add
            case "-":
                operation = Operation.substract
            case "X":
                operation = Operation.multiply
            case "/":
                operation = Operation.divide
            default:
                operation = Operation.noOperation
            }
            
            result = Double(resultLabel.text!)!
            secondNumber = 0.0
        }
    }
    
    @IBAction func addDecimal(_ sender: UIButton) {
        if !isCalculating {
            resultString = resultLabel.text!
            if !resultString.contains(".") {
                resultString += "."
                resultLabel.text = resultString
            }
        } else {
            secondNumberString += "."
            resultLabel.text = secondNumberString
        }
    }
    
    
    @IBAction func equalPressed(_ sender: UIButton) {
        if isCalculating {
            switch operation.rawValue {
            case "+":
                result = calculate(num1: result, num2: secondNumber, operation: operation.rawValue)
            case "-":
                result = calculate(num1: result, num2: secondNumber, operation: operation.rawValue)
            case "X":
                result = calculate(num1: result, num2: secondNumber, operation: operation.rawValue)
            case "/":
                if secondNumber != 0 {
                    result = calculate(num1: result, num2: secondNumber, operation: operation.rawValue)
                } else {
                    resultLabel.text = "ERROR"
                    resetAll()
                }
            default:
                return
            }
            
            displayResult(myResult: result)
            
            isCalculating = false
            operation = Operation.noOperation
        }
    }
    
    func resetAll() {
        result = 0.0
        resultString = ""
        secondNumber = 0.0
        secondNumberString = ""
        isCalculating = false
        operation = Operation.noOperation
        resultLabel.text = "0"
    }
    
    func calculate(num1: Double, num2: Double, operation: String) -> Double {
        var result = num1
        if operation == "+" {
            result += num2
        } else if operation == "-" {
            result -= num2
        } else if operation == "X" {
            result *= num2
        } else if operation == "/" {
            result /= num2
        }
        return result
    }
    
    func displayResult(myResult: Double) {
        if String(myResult).contains(".0") {
            resultLabel.text = String(Int(myResult))
        }
        else {
            if String(result).count != 9 {
                resultLabel.text = String(format:"%.2f", myResult)
            }
        }
    }
    
}

