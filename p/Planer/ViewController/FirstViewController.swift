//
//  FirstViewController.swift
//  Planer
//
//  Created by Philip Hannemann on 4/9/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import UIKit
import UserNotifications

class FirstViewController: UIViewController {

    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var uiStepper: UIStepper!
    
    let storage = Storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        
        updateNotifications()
        let timeLeft = storage.time(forKey: "BA")
        counter.text = "\(timeLeft.hour)"
        uiStepper.value = Double(timeLeft.hour)
        
    }


    @IBAction func pressedUPDown(_ stepper: UIStepper) {
        counter.text = "\(Int(stepper.value))"
        storage.set((Int(stepper.value), 0), forKey: "BA")
        updateNotifications()
    }
    
    
    func updateNotifications(){
        let times = [(9,00), (13, 30), (16, 00), (20, 00)]
        
        let content = UNMutableNotificationContent()
        content.title = "Konto"
        let timeLeft = storage.time(forKey: "BA")
        content.body = "Bachelorarbeit: \(timeLeft.hour)h, \(timeLeft.minutes)min left"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = Categories.saldo.rawValue
        
        for (hour, minute) in times {
            var date = DateComponents()
            date.hour = hour
            date.minute = minute
            let triggerCal = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            let request = UNNotificationRequest(identifier: "saldoUN\(hour):\(minute)", content: content, trigger: triggerCal)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
}

