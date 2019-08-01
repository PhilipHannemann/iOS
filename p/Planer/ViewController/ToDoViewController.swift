//
//  ToDo_View_Controller.swift
//  Planer
//
//  Created by Philip Hannemann on 4/16/19.
//  Copyright © 2019 Philip Hannemann. All rights reserved.
//

import UIKit
import CircularButtons

class ToDoViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heading: UILabel!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTasks()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(changeHeading(_:)))
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(rightSwipe)
    }
    
    func updateTasks(){
        tasks = Tasks().getAllTasks()
    }
    
    @objc func changeHeading(_ gestureRecognizer: UISwipeGestureRecognizer) {
        print("Gesture detected")
        if gestureRecognizer.state == .ended {
            print("Gesture performed")
        }
    }
    
}


extension ToDoViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateTasks()
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        updateTasks()
        let task = tasks[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") as? ToDoCell else {
            return UITableViewCell()
        }
        cell.set(taskName: task.name)
    
        return cell
    }
    
}

extension UIButton {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }
    
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }
    
}
