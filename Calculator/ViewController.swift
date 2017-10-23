//
//  ViewController.swift
//  Calculator
//
//  Created by Maxime REVEL on 23/10/2017.
//  Copyright © 2017 Maxime REVEL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    var stackNumber: Int?
    
    func applyOperation(myOperator: String, nb1: Int, nb2: Int) -> Int {
        switch myOperator {
        case "+":
            return nb1 + nb2
        case "-":
            return nb1 - nb2
        default:
            return 0
        }
        
        
    }
    
    @IBAction func didPressButton(_ sender: Any) {
        // Get a clicked number and add it in resultLabel
        guard let button = sender as? UIButton else {
            return
        }
        guard let text = button.titleLabel?.text else {
            return
        }
        let resLabel = resultLabel.text
        if resLabel == "0" {
            resultLabel.text = text
        } else {
            resultLabel.text = (resultLabel.text ?? "") + text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.resultLabel.text = "0"
        self.operatorLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func operation(_ sender: Any) {
        // Get an operator and apply it in operandLabel
        guard let button = sender as? UIButton else {
            return
        }
        guard let text = button.titleLabel?.text else {
            return
        }
        // Put operator in interface
        operatorLabel.text = text
        
        // Refresh result
        guard let number = Int(resultLabel.text!) else {
            return
        }
        if let currentNumber = stackNumber {
            resultLabel.text = String(applyOperation(myOperator: text, nb1: currentNumber, nb2: number))
            stackNumber = currentNumber
        } else {
            stackNumber = number
        }
    }
    
    @IBAction func pressEqual(_ sender: Any) {
        guard let currentOperator = operatorLabel.text else {
            return
        }
        if(currentOperator == "") {
            return
        } else {
            if let stackedNumber = stackNumber {
                guard let currentNumber = resultLabel.text else {
                    return
                }
                resultLabel.text = String(applyOperation(myOperator: currentOperator,nb1: stackedNumber,nb2: Int(currentNumber)!))
                operatorLabel.text = ""
            }
            
        }
    }
    
}

