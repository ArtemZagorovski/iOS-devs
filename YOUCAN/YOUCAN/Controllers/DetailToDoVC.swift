//
//  DetailToDoVC.swift
//  YOUCAN
//
//  Created by Артем  on 3/31/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class DetailToDoVC: UIViewController {
    
    var currentTask: Task!
    let notificationManager = NotificationManager()

    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDesc: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var importantSwitcher: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEditScreen()
    }
    
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        timePicker.alpha = 1
    }
    

    @IBAction func saveButton(_ sender: UIButton) {
        saveTask()
        navigationController?.popViewController(animated: true)
        
    }
    
    
    func saveTask() {
        
        var strDate: String?
        if timePicker.alpha == 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            strDate = dateFormatter.string(from: timePicker.date)
        } else {
            strDate = nil
        }
        
        let newTask = Task(title: taskTitle.text!,
                           taskDescription: taskDesc.text ?? "",
                           timeInterval: strDate ?? "",
                           important: importantSwitcher.isOn)
        
        if !newTask.timeInterval!.isEmpty && importantSwitcher.isOn{
            
            notificationManager.sendNotification(title: "Reminder",
                                                 body: newTask.title,
                                                 identifier: newTask.title,
                                                 date:Calendar.current.date(byAdding: .hour, value: -1, to: timePicker.date)!,
                                                 repeats: false)
        }
        
        if currentTask != nil {
            try! realm.write{
                currentTask.title = newTask.title
                currentTask.taskDescription = newTask.taskDescription
                currentTask.timeInterval = newTask.timeInterval
                currentTask.isImportant = newTask.isImportant
            }
            if !newTask.timeInterval!.isEmpty && newTask.timeInterval != currentTask.timeInterval{
                notificationManager.removeNotification(identifier: [currentTask.title])
                
                notificationManager.sendNotification(title: "Reminder",
                                                     body: newTask.title,
                                                     identifier: newTask.title,
                                                     date:Calendar.current.date(byAdding: .hour, value: -1, to: timePicker.date)!,
                                                     repeats: false)
            }
            
        } else {
            StorageManager.saveTaskToDo(newTask)
        }
    }
    
    private func setupEditScreen() {
        
        timePicker.alpha = 0.3
        importantSwitcher.isOn = false
        
        if currentTask != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.short
            dateFormatter.timeStyle = DateFormatter.Style.short
            let currentDateString = dateFormatter.string(from: Date())
            if currentTask.timeInterval!.isEmpty{
                let date = dateFormatter.date(from: currentDateString)
                timePicker.date = date!
            } else {
                let date = dateFormatter.date(from: currentTask.timeInterval!)
                timePicker.date = date!
            }
            
            taskTitle.text = currentTask.title
            taskDesc.text = currentTask.taskDescription
            importantSwitcher.isOn = currentTask.isImportant
        }
        
    }
}

extension DetailToDoVC: UITextFieldDelegate {
    //скрываем клавиатуру по нажатию Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
