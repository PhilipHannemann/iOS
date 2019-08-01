//
//  ViewController.swift
//  Organizer
//
//  Created by Philip Hannemann on 12/8/18.
//  Copyright © 2018 Philip Hannemann. All rights reserved.
//

import UIKit

class MyCheckListViewController: UITableViewController {

    var list = [String:Bool]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list["Walk the dog"] = false
        list["Learn iOS development"] = false
        list["Brush my teeth"] = false
        list["Do homework #2"] = false
        list["Do final project"] = false
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        
        let label = cell.viewWithTag(1000) as! UILabel
        
        let key = Array(list)[indexPath.row].key
        
        label.text = key
        
        list[key] = !Array(list)[indexPath.row].value
        
        if let s = list[key] {
            if s{
                cell.accessoryType = .checkmark
            }else{
                cell.accessoryType = .none
            }
        }
        
        
        return cell
    }
    

    
}

