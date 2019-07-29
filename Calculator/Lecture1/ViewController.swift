//
//  ViewController.swift
//  Lecture1
//
//  Created by Philip on 05.08.15.
//  Copyright (c) 2015 Philip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var wirSindInDerMitteDerZahl = false
    
    @IBAction func numberPressed(sender: UIButton) {
        let zahl = sender.currentTitle!
        
        if wirSindInDerMitteDerZahl{
           display.text = display.text! + zahl
        }
        else{
            display.text = zahl
            wirSindInDerMitteDerZahl = true
        }

    }

    var zahlenStack = Array<Double>()
    @IBAction func enter() {
        wirSindInDerMitteDerZahl = false
        
        zahlenStack.append(displayValue)
        println("\(zahlenStack)")
        
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if wirSindInDerMitteDerZahl{
            enter()
        }
        
        switch operation{
        case "+": berechnung{ $0 + $1 }
        case "−": berechnung{ $1 - $0 }
        case "×": berechnung{ $1 * $0 }
        case "÷": berechnung{ $1 / $0 }
        case "√": berechnung{ sqrt($0) }
        default: break
            
        }
        
        
    }
    
    func berechnung(berechnen: Double->Double){
        if zahlenStack.count >= 2{
            displayValue = berechnen(zahlenStack.removeLast())
            enter()
        }
    }
    
    func berechnung(berechnen: (Double,Double)->Double ){
        if zahlenStack.count >= 2{
            displayValue = berechnen(zahlenStack.removeLast(),zahlenStack.removeLast())
            enter()
        }
    }
    
   

    
    var displayValue: Double{
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            wirSindInDerMitteDerZahl = false
        }
    }

}

