//
//  CreateTaskViewController.swift
//  TaskDeck
//
//  Created by Theron Mansilla on 10/15/20.
//

import UIKit
import RealmSwift

class CreateTaskViewController: UIViewController {

    @IBOutlet weak var taskDescriptionTextField: UITextField!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        taskDescriptionTextField.becomeFirstResponder()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        if self.taskDescriptionTextField.text?.isEmpty == false {
            let newTask = Task()
            newTask.taskDescription = taskDescriptionTextField.text!
            newTask.dueDate = taskDueDatePicker.date
            
            try! realm.write {
                realm.add(newTask)
            }
            
            navigationController?.popViewController(animated: true)
            print("dismissing")
        }
        
    }
    
}
