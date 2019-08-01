//
//  NewTaskViewController.swift
//  Planer
//
//  Created by Philip Hannemann on 4/20/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import UIKit

class NewTaskViewController: UIViewController {

    @IBOutlet weak var taskNameDisplay: UITextField!
    @IBOutlet weak var timeDisplayH: UITextField!
    @IBOutlet weak var timeDisplayMin: UITextField!
    
    let storage = Storage()
    let tasks = Tasks()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goBackAndSafe(_ sender: UIBarButtonItem) {
        safe()
        self.dismiss(animated: true)
    }

    @IBAction func goBackWithoutSafe(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
    func safe(){
        guard let name = taskNameDisplay.text else {return}
        if(name == ""){ return }
        
        let timeH = Int(timeDisplayH.text ?? "") ?? 0
        let timeMin = Int(timeDisplayMin.text ?? "") ?? 0
        let time = (timeH, timeMin)
        
        storage.set(time, forKey: name)
        tasks.add(task: name)
        
    }
    
    
}
