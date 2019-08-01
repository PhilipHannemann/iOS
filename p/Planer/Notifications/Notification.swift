//
//  Notification.swift
//  Planer
//
//  Created by Philip Hannemann on 4/10/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import Foundation
import UserNotifications

extension Date {
    func getHour() -> Int{
        let calendar = Calendar.current
        return calendar.component(.hour, from: self)
    }
    
    func getMinute() -> Int{
        let calendar = Calendar.current
        return calendar.component(.minute, from: self)
    }
    
    func goForwardInTime(hours:Int, minutes:Int)->Date{
        let calendar = Calendar.current
        guard let date = calendar.date(byAdding: .hour, value: hours, to: self) else {
            return self
        }
        guard let newDate = calendar.date(byAdding: .minute, value: minutes, to: date) else {
            return self
        }
        return newDate
    }
    
    func getCurrent()->(hours:Int, minutes:Int){
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let min = calendar.component(.minute, from: self)
        return (hour, min)
    }
}

class Notification {
    var id:String
    var title:String = ""
    var body: String = ""
    var launchTime:Date = Date()
    var category:Categories = .info
    let storage = UserDefaults.standard
    var attachedTask = Task(name: "", timeRemaining: (0, 0))
    
    init(id:String) {
        self.id = id
    }
    
    
    func show(){
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = category.rawValue
        
        content.userInfo["taskName"] = attachedTask.name
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
    }
    
    func plan(forDate date:Date){
        plan(forDate: (date.getHour(), date.getMinute()))
    }
    
    func plan(forDate date:(hour: Int, minutes:Int)){
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = category.rawValue
        
        content.userInfo["taskName"] = attachedTask.name
        
        var dateComponent = DateComponents()
        dateComponent.hour = date.hour
        dateComponent.minute = date.minutes
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func safeTime(){
        storage.set(launchTime.getHour(), forKey: "START_HOUR_"+id)
        storage.set(launchTime.getMinute(), forKey: "START_MINUTE_"+id)
    }
    
    func getStartTime() -> (hour:Int, minute:Int) {
        let hour = storage.integer(forKey: "START_HOUR_"+id)
        let minutes = storage.integer(forKey: "START_MINUTE_"+id)
        
        return (hour, minutes)
    }
}
