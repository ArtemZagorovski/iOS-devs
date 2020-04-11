//
//  GoalsVC.swift
//  YOUCAN
//
//  Created by Артем  on 4/1/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift

class GoalsVC: UITableViewController {

    var goals: Results<Goal>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goals = realm.objects(Goal.self)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return goals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Goal", for: indexPath) as! GoalCell

        let goal = goals[indexPath.row]
        
        let transform = CGAffineTransform(scaleX: 1.0, y: 10.0);
        cell.progressView.transform = transform
        cell.progressView.layer.cornerRadius = 10
        cell.progressView.clipsToBounds = true
        cell.progressView.layer.sublayers![1].cornerRadius = 10
        cell.progressView.subviews[1].clipsToBounds = true
        
        cell.iconOfGoal.image = UIImage(named: goal.typeName)
        cell.titleOfGoal.text = goal.title
        cell.progressView.progress = goal.progress
        cell.percentOfGoal.text = String(goal.progress)
        
        cell.doItButton.addTarget(self, action: #selector(doItButtonTapped), for: .touchUpInside)
        cell.doItButton.tag = indexPath.row
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let goal = goals![indexPath.row]
            StorageManager.deliteGoal(goal)
        }
        //tableView.reloadData()
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeGoalSegue" {
            let addGoalVC = segue.destination as! GoalDetailTVC
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            addGoalVC.currentGoal = goals[indexPath.row]
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if segue.identifier == "goalUnwindSegue" {
            guard let addGoalTVC = segue.source as? GoalDetailTVC else { return }
            
            addGoalTVC.saveGoal()
            
            tableView.reloadData()
        }
        
    }
    
    //MARK: Custom func
    
    @objc func doItButtonTapped(sender: UIButton) {
        let buttonTag = sender.tag
        
        let goal = goals[buttonTag]
        
        var progress = goal.progress
        
        if goal.isTime {
            
            var multyplier = 1
            
            switch goal.countOfTimesInWeek {
            case "Every day":
                multyplier = 30
            case "In one day":
                multyplier = 15
            case "Once a week":
                multyplier = 4
            default:
                print("error in goal.isTime")
            }
            goal.timeIn * goal.countOfMonth
        }
    }
}

