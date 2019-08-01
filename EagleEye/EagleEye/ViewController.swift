//
//  ViewController.swift
//  EagleEye
//
//  Created by Angus yeung on 4/21/18.
//  Copyright © 2018 Angus Yeung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue : Int = 50
    var targetValue : Int = 50
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    var score : Int = 0
    var round : Int = 0
    
    func startNewRound() {
        currentValue = 50
        targetValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        round += 1
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewRound()
        updateLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAction() {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        

        let title : String
        
        if difference == 0 {
            title = "You got eagle's eyes"
            points += 100
        } else if difference < 5 {
            title = "You almost had it"
            points += 50
        } else if difference < 10 {
            title = "Pretty good"
        } else {
            title = "Not so good... but try again"
        }
        
        score += points
        
        let message = "You scored \(points) points"
        
        let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert)
        
        let action = UIAlertAction(
                title: "OK!",
                style: .default,
                handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        startNewRound()
        updateLabels()
    }

    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
        print("The value of the slider is now: \(currentValue)")
    }


}

