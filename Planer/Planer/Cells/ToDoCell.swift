//
//  ToDoCell.swift
//  Planer
//
//  Created by Philip Hannemann on 4/16/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import UIKit
import UserNotifications

class ToDoCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var valueDisplay: UILabel!
    
    let storage = Storage()
    var value = 0
    let saldo = Saldo()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(taskName:String){
        self.taskName.text = taskName
        
        self.value = storage.time(forKey: taskName).hour
        valueDisplay.text = "\(value)"
        
        let times = [(9,00), (13, 30), (16, 00), (20, 00)]
        saldo.setTimeScedule(forTimes: times)
    }
    
    
    @IBAction func subtractValue(_ sender: UIButton) {
        value -= 1
        valueDisplay.text = "\(value)"
        
        updateStorage()
    }
    
    @IBAction func addValue(_ sender: UIButton) {
        value += 1
        valueDisplay.text = "\(value)"
        
        updateStorage()
    }
    
    func updateStorage(){
        let key = taskName.text ?? ""
        
        storage.set((value, 0), forKey: key)
        updateNotifications()
    }
    
    
    func updateNotifications(){
        saldo.update()
    }
    

}
