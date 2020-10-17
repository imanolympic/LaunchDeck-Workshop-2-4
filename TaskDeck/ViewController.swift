//
//  ViewController.swift
//  TaskDeck
//
//  Created by Theron Mansilla on 10/15/20.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    let realm = try! Realm()
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tasksTableView.delegate = self
        tasksTableView.dataSource = self
        tasksTableView.rowHeight = UITableView.automaticDimension
        tasksTableView.estimatedRowHeight = 150
  
        tasks = realm.objects(Task.self).filter("isCompleted == false").sorted(byKeyPath: "dueDate", ascending: true).map({ $0 })
        print(tasks)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tasks = realm.objects(Task.self).filter("isCompleted == false").sorted(byKeyPath: "dueDate", ascending: true).map({ $0 })
        tasksTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task Cell") as! TaskTableViewCell
        
        let task = self.tasks[indexPath.row]
        
        cell.configure(description: task.taskDescription, dueDate: task.dueDate!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteSwipeAction = UIContextualAction(style: .destructive, title: "Delete Task") { (action, view, completion) in
            let taskToDelete = self.tasks[indexPath.row]
            
            self.tasks.remove(at: indexPath.row)
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            try! self.realm.write {
                self.realm.delete(taskToDelete)
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteSwipeAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeTaskAction = UIContextualAction(style: .normal, title: "Complete") { (action, view, completion) in
            let taskToBeCompleted = self.tasks[indexPath.row]
            
            try! self.realm.write {
                taskToBeCompleted.isCompleted = true
            }
            
            self.tasks = self.realm.objects(Task.self).filter("isCompleted == false").map({ $0 })
            tableView.reloadData()
        }
        completeTaskAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [completeTaskAction])
    }
    
}

