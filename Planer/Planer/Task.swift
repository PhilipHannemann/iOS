//
//  Task.swift
//  Planer
//
//  Created by Philip Hannemann on 4/16/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import Foundation

class Task{
    var name:String = ""
    var timeRemaining:(hour:Int, minutes:Int) = (0,0)
    
    init(name:String, timeRemaining:(hour:Int, minutes:Int)) {
        self.name = name
        self.timeRemaining = timeRemaining
    }
}
