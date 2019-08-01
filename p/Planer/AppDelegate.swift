//
//  AppDelegate.swift
//  Planer
//
//  Created by Philip Hannemann on 4/9/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    let storage = Storage()
    let notificationGroups = Tasks()
    let saldo = Saldo()
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo as? [String:String] ?? [:]
        let taskName = userInfo["taskName"] ?? ""
        let task = Tasks().getTask(forName: taskName) ?? Task(name: "", timeRemaining: (0,0))
        
        print("TaskName of UNAction: "+task.name)
        
        if let action = NotificationButtons(rawValue: response.actionIdentifier){
            switch action {
                case .startWorking:
                    
                    let startNotification = Notification(id: "start")
                    startNotification.title = "Working"
                    startNotification.body = task.name + " - start: "+String(startNotification.launchTime.getHour())+":"+String(startNotification.launchTime.getMinute())
                    startNotification.category = .working
                    startNotification.attachedTask = task
                    startNotification.show()
                    storage.set(startNotification.launchTime, forKey: task.name + "_START_WORKING")
                    
                    
                    let timeLeft = storage.time(forKey: task.name)
                    
                    let endDate = Date().goForwardInTime(hours: timeLeft.hour, minutes: timeLeft.minutes)
                    
                    let doneNotification = Notification(id: "done")
                    doneNotification.title = "Working - DONE"
                    doneNotification.body = "Du hast erstmal genug für \""+task.name+"\" gemacht"
                    doneNotification.attachedTask = task
                    doneNotification.plan(forDate: endDate)
                
                
                case .stopWorking:
                    
                    let startDoingTime = storage.time(forKey: task.name + "_START_WORKING")
                    
                    let deltaH = Date().getHour() - startDoingTime.hour
                    let deltaMin = Date().getMinute() - startDoingTime.minutes
                    
                    let timeLeft = storage.time(forKey: task.name)
                    var minLeft = timeLeft.minutes - deltaMin
                    var hourLeft = timeLeft.hour - deltaH
                    if(timeLeft.hour >= 0 && timeLeft.minutes >= 0){
                        if(minLeft < 0){
                            minLeft += 60
                            hourLeft -= 1
                        }
                    }else{
                        if(minLeft < -60){
                            minLeft += 60
                            hourLeft -= 1
                        }
                    }
                   
                    storage.set((hourLeft, minLeft), forKey: task.name)
                    stopWorking()
                    saldo.show()
            }
        }
        
        completionHandler()
    }

    
    
    func stopWorking(){
        let doneNotification = Notification(id: "done")
        doneNotification.plan(forDate: Date().goForwardInTime(hours: -1, minutes: 0))
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.delegate = self
        
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {(granted, error) in
            print("granted: \(granted)")
        })
        
        let startWorking = UNNotificationAction(identifier: NotificationButtons.startWorking.rawValue,
                                        title: "begin doing something",
                                        options: UNNotificationActionOptions(rawValue: 0))
        let stopWorking = UNNotificationAction(identifier: NotificationButtons.stopWorking.rawValue,
                                                  title: "stop working",
                                                  options: UNNotificationActionOptions(rawValue: 0))
        
        // Define the notification type
        let saldoCategory = UNNotificationCategory(identifier: Categories.saldo.rawValue,
                                   actions: [startWorking],
                                   intentIdentifiers: [],
                                   hiddenPreviewsBodyPlaceholder: "",
                                   options: .customDismissAction)
        let workingCategory = UNNotificationCategory(identifier: Categories.working.rawValue,
                                                   actions: [stopWorking],
                                                   intentIdentifiers: [],
                                                   hiddenPreviewsBodyPlaceholder: "",
                                                   options: .customDismissAction)
        
        // Register the notification type.
        notificationCenter.setNotificationCategories([saldoCategory, workingCategory])
        Tasks().deleteTask(forName: "")
        
        saldo.show()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

