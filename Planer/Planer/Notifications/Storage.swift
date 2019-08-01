//
//  Storage.swift
//  Planer
//
//  Created by Philip Hannemann on 4/11/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import Foundation

class Storage {
    let storage = UserDefaults.standard
    
    func set(_ value:Int, forKey key: String){
        storage.set(value, forKey: key)
    }
    
    func set(_ value:Double, forKey key: String){
        storage.set(value, forKey: key)
    }
    
    func set(_ value:Date, forKey key: String) {
        storage.set(value.getHour(), forKey: key+"_HOUR")
        storage.set(value.getMinute(), forKey: key+"_MINUTE")
    }
    
    func set(_ value:(Int, Int), forKey key: String){
        storage.set(value.0, forKey: key+"_HOUR")
        storage.set(value.1, forKey: key+"_MINUTE")
    }
    
    func set(_ value:[String], forKey key: String){
        storage.set(value, forKey: key)
    }
    
    func addTaArray(_ value:String, forKey key:String){
        if var array = stringArray(forKey: key){
            array.append(value)
            set(array, forKey: key)
        }else{
            set([value], forKey: key)
        }
    }
    
    func time(forKey key:String) ->(hour: Int, minutes: Int){
        let hour = storage.integer(forKey: key+"_HOUR")
        let minute = storage.integer(forKey: key+"_MINUTE")
        
        return (hour, minute)
    }
    
    func integer(forKey key:String) -> Int{
        return storage.integer(forKey: key)
    }
    
    func double(forKey key:String) -> Double{
        return storage.double(forKey: key)
    }
    
    func stringArray(forKey key:String) -> [String]?{
        return storage.array(forKey: key) as? [String]
    }
}
