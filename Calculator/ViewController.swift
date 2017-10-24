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
    
    var stackNumber: Int = 0
    var justPressedOperator: Bool = false
    
    func applyOperation(myOperator: String, nb1: Int, nb2: Int) -> Int {
        switch myOperator {
        case "+":
            return nb1 + nb2
        case "-":
            return nb1 - nb2
        case "x":
            return nb1 * nb2
        case "/":
            return nb1 / nb2
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
        if justPressedOperator || resLabel == "0" {
            resultLabel.text = text
            justPressedOperator = false
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
        // Get an operator and apply it in operatorLabel
        guard let button = sender as? UIButton else {
            return
        }
        guard let text = button.titleLabel?.text else {
            return
        }
        // Put operator in interface
        operatorLabel.text = text
        // Set boolean to true : next time we press number, should empty result
        justPressedOperator = true
        
        // Refresh result
        guard let number = Int(resultLabel.text!) else {
            return
        }
        if stackNumber != 0 {
            resultLabel.text = String(applyOperation(myOperator: text, nb1: stackNumber, nb2: number))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resultLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UILabel.animate(withDuration: 2) {
            self.resultLabel.alpha = 1
        }
    }
    
    @IBAction func pressEqual(_ sender: Any) {
        /* 
         * Does not work
         */
        justPressedOperator = true
        guard let currentOperator = operatorLabel.text else {
            return
        }
        if(currentOperator == "") {
            return
        } else {

            guard let currentNumber = resultLabel.text else {
                return
            }
            resultLabel.text = String(applyOperation(myOperator: currentOperator, nb1: stackNumber, nb2: Int(currentNumber)!))
            operatorLabel.text = nil
            stackNumber = 0
            
        }
    }
    
    @IBAction func pressClear(_ sender: Any) {
        guard let resLabel = resultLabel, let opLabel = operatorLabel else {
            return
        }
        resLabel.text = "0"
        opLabel.text = nil
        stackNumber = 0
        justPressedOperator = false
    }
}
