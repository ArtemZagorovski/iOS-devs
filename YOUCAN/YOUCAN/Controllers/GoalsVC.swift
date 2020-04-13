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
        cell.progressView.setProgress(goal.progress, animated: true)
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
    
    @objc func doItButtonTapped(sender: UIButton) {
        let buttonTag = sender.tag
        let goal = goals[buttonTag]
        let progress = goal.progress
        
        
        if progress <= 1.0 && !goal.isDone {
            if goal.isTime {
                let todayProgress = Float(goal.timeIn) / goal.finalTask
                try! realm.write{
                    goal.progress = progress + todayProgress
                }
            }
            
            if goal.isTimes {
                var timesDone: Int?
                if timesDone == nil { timesDone = 0 }
                
                
                let dateComponentsFromStart = Calendar.current.dateComponents([.day, .month, .year], from: goal.startDate)
                let dateFromSart = Calendar.current.date(from: dateComponentsFromStart)
                let today = Date()
                let dateComponentsToday = Calendar.current.dateComponents([.day, .month, .year], from: today)
                let dateToday = Calendar.current.date(from: dateComponentsToday)
                
                switch goal.countOfTimesInString {
                    
                case "Day":
                    let isToday = Calendar.current.compare(dateFromSart!, to: dateToday!, toGranularity: .day)
                    if isToday == .orderedSame {
                        
                        let todayProgress: Float = 1 / Float(goal.countOfTimesIn)
                        try! realm.write{
                            goal.progress = progress + Float(todayProgress)
                            if checkIsCompleted (timesDone: timesDone!, goal: goal)  { goal.isDone = true } else { timesDone! += 1 }
                        }
                    } else {
                        try! realm.write{
                            goal.progress = 0.0
                            goal.startDate = Date()
                        }
                    }
                    
                case "Week":
                    var dayComponent = DateComponents()
                    dayComponent.day = 7
                    let nextDate = Calendar.current.date(byAdding: dayComponent, to: goal.startDate)
                    
                    let isInWeekFirst = Calendar.current.compare(dateFromSart!, to: dateToday!, toGranularity: .day)
                    let isInWeekSecond = Calendar.current.compare(dateToday!, to: nextDate!, toGranularity: .day)
                    
                    if (isInWeekFirst == .orderedSame || isInWeekFirst == .orderedDescending) && (isInWeekSecond == .orderedSame || isInWeekSecond == .orderedAscending) {
                        let todayProgress: Float = 1 / Float(goal.countOfTimesIn)
                        print(todayProgress)
                        try! realm.write{
                            goal.progress = progress + Float(todayProgress)
                            print(goal.progress)
                        }
                    } else {
                        try! realm.write{
                            goal.progress = 0.0
                            goal.startDate = Date()
                        }
                    }
                    
                case "Month":
                    let isToday = Calendar.current.compare(dateFromSart!, to: dateToday!, toGranularity: .month)
                    if isToday == .orderedSame {
                        
                        let todayProgress: Float = 1 / Float(goal.countOfTimesIn)
                        try! realm.write{
                            goal.progress = progress + Float(todayProgress)
                            print(goal.progress)
                        }
                    } else {
                        try! realm.write{
                            goal.progress = 0.0
                            goal.startDate = Date()
                        }
                    }
                default:
                    print("error in times")
                }
            }
        }
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
    }
    
    private func checkIsCompleted (timesDone: Int, goal: Goal) -> Bool {
        if timesDone == goal.timesIn {
            finishGoalAlert()
            return true
        } else {
            return false
        }
    }
    
    private func finishGoalAlert() {
        let ac = UIAlertController(title: "You did it!", message: "You have achived your goal! Congradulations!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(ac, animated: true)
    }
}


