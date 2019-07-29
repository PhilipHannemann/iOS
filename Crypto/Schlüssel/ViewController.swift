//
//  ViewController.swift
//  Schlüssel
//
//  Created by Philip on 26.08.15.
//  Copyright (c) 2015 Philip. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //var entschlüsselungsTabelle = "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZäÄöÖüÜß1234567890^!?,.:;*)"
    var entschlüsselungsTabelle = "abcdefghijklmnopqrstuvwxyzßäöü,."

    
    @IBOutlet weak var direktion: UISegmentedControl!
    @IBOutlet weak var richtung: UISegmentedControl!
    @IBOutlet weak var myText: UITextView!
    @IBOutlet weak var Schlüssel: UITextField!
    @IBOutlet weak var UebersetzterText: UITextView!
    
    @IBAction func SchluesselEingabe(sender: AnyObject) {
        var original = myText.text!
        var key = Schlüssel.text!
        
        if key != ""{
            UebersetzterText.text = ""
            
            for buchstabe in original{
                if buchstabe != " "{
                    if key == "" {
                        key = Schlüssel.text!
                    }
                    
                    let k = Array(key)[0]
                    var verschiebung = 0
                    var posBuchstabe = 0
                    
                    for c in entschlüsselungsTabelle{
                        if c == k{
                            break
                        }
                        if direktion.selectedSegmentIndex == 0{
                            ++verschiebung
                        } else{
                            --verschiebung
                        }
                    }
                    for character in entschlüsselungsTabelle{
                        if character == buchstabe{
                            break
                        }
                        
                        ++posBuchstabe
                    }
                    
                    if direktion.selectedSegmentIndex == 0{
                        if verschiebung + posBuchstabe > count(entschlüsselungsTabelle)-1{
                            verschiebung -= count(entschlüsselungsTabelle)
                        }
                    }
                    else{
                        if verschiebung + posBuchstabe < 0{
                            verschiebung += count(entschlüsselungsTabelle)
                        }
                    }
                    
                    UebersetzterText.text = UebersetzterText.text! + String(Array(entschlüsselungsTabelle)[verschiebung + posBuchstabe])
                    
                    let länge = count(key)
                    key = String(Array(key)[1..<länge])
                }
                else{
                    UebersetzterText.text = UebersetzterText.text! + " "
                }
                
            }
            
            
            
            
        }
    }
    

}

