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
    private var importantTasks: Results<Task>!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realm.objects(Task.self)
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 1 {
            return importantTasks?.count ?? 0
        } else {
            return tasks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TaskCell
        let task: Task
        if segmentedControl.selectedSegmentIndex == 1 {
            task = importantTasks[indexPath.row]
        } else {
            task = tasks[indexPath.row]
        }
        
        cell.titleLabel.text = task.title
        cell.descLabel.text = task.taskDescription
        cell.timeIntervalLabel.text = task.timeInterval
        cell.isDoneButton.tag = indexPath.row
        print(indexPath)
        cell.isDoneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        if task.isDone == true {
            cell.titleLabel.alpha = 0.3
            cell.descLabel.alpha = 0.3
            cell.timeIntervalLabel.alpha = 0.3
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
    
    //MARK: Methods for sorting tasks
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        sorting()
    }
    
    func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            tasks = tasks.sorted(byKeyPath: "time", ascending: true)
        }
        if segmentedControl.selectedSegmentIndex == 1 {
            importantTasks = tasks.filter("isImportant = true")
        }
        tableView.reloadData()
    }
    
    //MARK: - Method for button
    @objc func doneButtonTapped(sender: UIButton) {
        let buttonTag = sender.tag
        let task = tasks[buttonTag]
        
        try! realm.write{
            task.isDone = !task.isDone
        }
        tableView.reloadRows(at: [[0, buttonTag]], with: .fade)
    }
}
