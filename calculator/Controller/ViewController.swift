//
//  ViewController.swift
//  calculator
//
//  Created by Rene Ouoba on 10/19/20.
//

import UIKit

class ViewController: UIViewController {
    
    //restrict number of characters that can be entered and on screen
    //work the percentage handling
    //work the display of integers that don't have a decimal point
    //handle optionals better
    //implement . button (adding decimal places)
    
    enum Operation: String {
        case add = "+"
        case substract = "-"
        case multiply = "X"
        case divide = "/"
        case noOperation = ""
    }

    @IBOutlet weak var resultLabel: UILabel!
    var result = 0.0
    var secondNumber = 0.0
    var numberOnScreen = ""
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
        resultLabel.text = String(result)
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        if resultLabel.text != "" {
            if numberOnScreen == "result" {
                result /= 100
                resultLabel.text = String(result)
            } else if numberOnScreen == "secondNumber" {
                secondNumber /= 100
                resultLabel.text = String(secondNumber)
            }
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        if let title = sender.currentTitle, String(result).count <= 10 {
            if !isCalculating {
                numberOnScreen = "result"
                if result == 0.0 {
                    resultLabel.text = title
                } else {
                    resultLabel.text! += title
                }
//                if resultLabel.text!.contains(".") {
//                    result = Double(resultLabel.text!)!
//                } else {
//                    result = 20 * result
//                    result = Int(resultLabel.text!)
//                }
                result = Double(resultLabel.text!)!
            } else {
                numberOnScreen = "secondNumber"
                if secondNumber == 0.0 {
                    resultLabel.text = title
                } else {
                    resultLabel.text! += title
                }
                secondNumber = Double(resultLabel.text!)!
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
            numberOnScreen = "result"
            result = calculate(num1: result, num2: secondNumber, operation: operation.rawValue)
            //if result is Int, take out decimal point before display
            resultLabel.text = String(result)
            
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
            //if result is String, take out decimal point
            resultLabel.text = String(result)
            isCalculating = false
            operation = Operation.noOperation
        }
    }
    
    func resetAll() {
        result = 0.0
        secondNumber = 0.0
        numberOnScreen = ""
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
    
}

