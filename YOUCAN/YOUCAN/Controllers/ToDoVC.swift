//
//  ToDoVC.swift
//  YOUCAN
//
//  Created by Артем  on 3/29/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoVC: UITableViewController {
    
    //private var dayTasks: Results<DayTasks>!
    private var tasks: Results<Task>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realm.objects(Task.self)
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskCell
        let task = tasks[indexPath.row]
        
        cell.titleLabel.text = task.title
        cell.descLabel.text = task.taskDescription
        cell.timeIntervalLabel.text = task.timeInterval
        
        if task.isImportant {
            cell.contentView.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
            cell.titleLabel.textColor = .white
            cell.descLabel.textColor = .white
            cell.timeIntervalLabel.textColor = .white
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks![indexPath.row]
            StorageManager.deliteTaskToDo(task)
        }
        //tableView.reloadData()
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeTaskSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let task = tasks[indexPath.row]
            
            let detailToDo = segue.destination as! DetailToDoVC
            detailToDo.currentTask = task
        }
    }
    


}
