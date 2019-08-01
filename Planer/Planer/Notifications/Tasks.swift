//
//  Group.swift
//  Planer
//
//  Created by Philip Hannemann on 4/10/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import Foundation

class Tasks {
    let storage = Storage()
    
    func getAllNames() -> [String]{
        return storage.stringArray(forKey: "Tasks") ?? []
    }
    
    func getAllTasks() -> [Task]{
        let names = getAllNames()
        var tasks = [Task]()
        
        for name in names {
            let time = storage.time(forKey: name)
            tasks.append(Task(name: name, timeRemaining: time))
        }
        
        return tasks
    }
    
    func getTask(forName name:String) -> Task?{
        let tasks = getAllTasks()
        for task in tasks {
            if task.name == name {
                return task
            }
        }
        return nil
    }
    
    func add(task:String){
        var tasks = getAllNames()
        tasks.append(task)
        storage.set(tasks, forKey: "Tasks")
    }
    
    func add(tasks:[String]){
        for task in tasks{
            add(task: task)
        }
    }
    
    func deleteTask(forName task: String){
        let taskBefore = getAllNames()
        var tasksAfter = [String]()
        for taskNameBefore in taskBefore {
            if taskNameBefore != task {
                tasksAfter.append(taskNameBefore)
            }
        }
        storage.set(tasksAfter, forKey: "Tasks")
    }
}
