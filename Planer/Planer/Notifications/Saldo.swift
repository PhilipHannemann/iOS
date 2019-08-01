//
//  Saldo.swift
//  Planer
//
//  Created by Philip Hannemann on 4/13/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import Foundation

class Saldo {
    let storage = Storage()
    let tasks = Tasks()
    var scedule = [(hour:Int, minutes:Int)]()
    let saldoNotification = Notification(id: "saldo")
    
    init() {
        saldoNotification.title = "Konto"
        saldoNotification.category = .saldo
        update()
    }
    
    func setTimeScedule(forTimes times:[(hour:Int, minutes:Int)]){
        scedule = times
        update()
    }
    
    func update(){
        
        let tasksArray = tasks.getAllTasks()
        let count = tasksArray.count
        if(count == 0){return}
        
        let task = Int.random(in: 0 ..< count)
        
        let description = String(format: tasksArray[task].name + ": %dh %dmin left", tasksArray[task].timeRemaining.hour, tasksArray[task].timeRemaining.minutes)
        saldoNotification.body = description
        saldoNotification.attachedTask = tasksArray[task]
        
        for time in scedule {
            saldoNotification.id = "saldo\(time.hour):\(time.minutes)"
            saldoNotification.plan(forDate: time)
        }
    }
    
    func show(){
        update()
        saldoNotification.id = "saldo"
        saldoNotification.show()
    }
}
