//
//  ViewController.swift
//  Calculator
//
//  Created by Дмитро on 08.07.16.
//  Copyright © 2016 Ivanov Dmytro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet weak var displayResultLabel: UILabel!
    
    var stillTyping = false
    var firstOperand: Double = 0
    var secoundOperand: Double = 0
    var operationSign: String = ""
    var dotIsPlased = false
    
    var currentInput:Double{
        get{
            return Double(displayResultLabel.text!)!
        }
        set{
            let value = "\(newValue)"
            let valueArray = value.componentsSeparatedByString(".")
            if valueArray[1] == "0"{
                displayResultLabel.text = "\(valueArray[0])"
            }else{
                displayResultLabel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        let number = sender.currentTitle!
        if stillTyping{
            if displayResultLabel.text?.characters.count < 20{
                displayResultLabel.text = displayResultLabel.text! + number
            }
        }else{
            displayResultLabel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandSignPressed(sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlased = false
    }
    
    func operateWichTwoOperands(operation:(Double,Double) -> Double) {
        currentInput = operation(firstOperand,secoundOperand)
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(sender: UIButton) {
        if stillTyping {
            secoundOperand = currentInput
        }
        dotIsPlased = false
        switch operationSign {
            case "+":
                operateWichTwoOperands{$0 + $1}
            case "×":
                operateWichTwoOperands{$0 * $1}
            case "÷":
                operateWichTwoOperands{$0 / $1}
            case "-":
                operateWichTwoOperands{$0 - $1}
            default:
                break
        }
    }
    
    @IBAction func clearButtonPressed(sender: UIButton) {
        firstOperand = 0
        secoundOperand = 0
        currentInput = 0
        stillTyping = false
        displayResultLabel.text = "0"
        operationSign = ""
        dotIsPlased = false
    }
    
    @IBAction func plusMinusButtonPressed(sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(sender: UIButton) {
        if firstOperand == 0{
            currentInput = currentInput / 100
        }else{
            secoundOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    
    @IBAction func squareRootButtonPressed(sender: UIButton) {
        if currentInput >= 0{
            currentInput = sqrt(currentInput)
        }else{
            displayResultLabel.text = "0"
        }
    }
    
    @IBAction func UIButtondotButtonPressed(sender: UIButton) {
        if stillTyping && !dotIsPlased{
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlased = true
        }else if !stillTyping && !dotIsPlased{
            displayResultLabel.text = "0."
        }
    }
}

