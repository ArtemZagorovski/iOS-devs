//
//  GoalDetailTVC.swift
//  YOUCAN
//
//  Created by Артем  on 4/5/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class GoalDetailTVC: UITableViewController {

    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var typeButton: UIButton!
    
    @IBOutlet weak var goalTitleTF: UITextField!
    
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var firstPickerView: UIPickerView!
    @IBOutlet weak var minutesTF: UITextField!
    @IBOutlet weak var countOfMonthsTF: UITextField!
    
    @IBOutlet weak var timesButton: UIButton!
    @IBOutlet weak var timesTF: UITextField!
    @IBOutlet weak var timesInPickerLabel: UILabel!
    @IBOutlet weak var howManyTF: UITextField!
    @IBOutlet weak var secondPickerView: UIPickerView!
    
    @IBOutlet weak var saveMoneyButton: UIButton!
    @IBOutlet weak var howMuchTF: UITextField!
    @IBOutlet weak var everyMonthTF: UITextField!
    
    @IBOutlet weak var firstFromDatePicker: UIDatePicker!
    @IBOutlet weak var firstToDatePicker: UIDatePicker!
    
    
    var isTime = false
    var isTimes = false
    var isSaveMoney = false
    var isChooseButtonTapped = false
    //var isAddTimeButtonTapped = false
    
    let firstPickerContent = ["Every day", "In one day", "Once a week"]
    var firstPickerChose = "Every day"
    let secondPickerContent = ["Day", "Week", "Month"]
    var secondPickerChose = "Day"
    
    var currentGoal: Goal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        setupEditScreen()
        tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTouchesRequired = 1
        typeButton.addGestureRecognizer(tapGesture)
    }

    @objc private func tapped() {
        let resultController = self.storyboard?.instantiateViewController(withIdentifier: "popVC") as? TypePopOverVC
        resultController?.delegation = self
        
        resultController!.modalPresentationStyle = .popover
        
        let popOverVC = resultController?.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.typeButton
        popOverVC?.sourceRect = CGRect(x: self.typeButton.bounds.maxX, y: self.typeButton.bounds.midY, width: 50, height: 0)
        resultController!.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(resultController!, animated: true, completion: nil)
    }
    
    @IBAction func timeSectionTapped(_ sender: UIButton) {
        tableView.beginUpdates()
        isTime = !isTime
        isTimes = false
        isSaveMoney = false
        tableView.endUpdates()
    }
    
    @IBAction func timesSectionTapped(_ sender: UIButton) {
        tableView.beginUpdates()
        isTimes = !isTimes
        isTime = false
        isSaveMoney = false
        tableView.endUpdates()
    }
    
    @IBAction func saveSectionTapped(_ sender: UIButton) {
        tableView.beginUpdates()
        isSaveMoney = !isSaveMoney
        isTimes = false
        isTime = false
        tableView.endUpdates()
    }
    
    @IBAction func chooseButtonTapped(_ sender: UIButton) {
        tableView.beginUpdates()
        isChooseButtonTapped = !isChooseButtonTapped
        tableView.endUpdates()
    }
    //MARK: CustomFunc
    
    func saveGoal() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        let fromStrDate = dateFormatter.string(from: firstFromDatePicker.date)
        let toStrDate = dateFormatter.string(from: firstToDatePicker.date)
        var finalTaskCount: Float = 0.0
        
        if isTime {
            var multyplier: Float = 1
            switch firstPickerChose {
            case "Every day":
                multyplier = 30
            case "In one day":
                multyplier = 15
            case "Once a week":
                multyplier = 4
            default:
                print("error in goal.isTime")
            }
            finalTaskCount = (Float(minutesTF.text!) ?? 0) * (Float(countOfMonthsTF.text!) ?? 0) * multyplier
        }
        
        let newGoal = Goal(typeName: typeButton.titleLabel!.text!,
                           title: goalTitleTF.text ?? "",
                           timeIn: Int(minutesTF.text ?? "0"),
                           countOfMonth: Int(countOfMonthsTF.text ?? "0"),
                           countOfTimesInWeek: firstPickerChose,
                           isTime: isTime,
                           timesIn: Int(timesTF.text ?? "0"),
                           countOfTimesIn: Int(howManyTF.text ?? "0"),
                           countOfTimesInString: secondPickerChose,
                           isTimes: isTimes,
                           countOfMoney:  Int(howMuchTF.text ?? "0"),
                           countOfMoneyEveryMonth: Int(everyMonthTF.text ?? "0"),
                           isSaveMoney: isSaveMoney,
                           fromTime: fromStrDate,
                           toTime: toStrDate,
                           finalTask: finalTaskCount)
        if currentGoal != nil {
            try! realm.write{
                currentGoal.typeName = newGoal.typeName
                currentGoal.title = newGoal.title
                currentGoal.timeIn = newGoal.timeIn
                currentGoal.countOfMonth = newGoal.countOfMonth
                currentGoal.countOfTimesInWeek = newGoal.countOfTimesInWeek
                currentGoal.isTime = newGoal.isTime
                currentGoal.timesIn = newGoal.timesIn
                currentGoal.countOfTimesIn = newGoal.countOfTimesIn
                currentGoal.countOfTimesInString = newGoal.countOfTimesInString
                currentGoal.isTimes = newGoal.isTimes
                currentGoal.countOfMoney = newGoal.countOfMoney
                currentGoal.countOfMoneyEveryMonth = newGoal.countOfMoneyEveryMonth
                currentGoal.isSaveMoney = newGoal.isSaveMoney
                currentGoal.fromTime = newGoal.fromTime
                currentGoal.toTime = newGoal.toTime
            }
        } else {
            StorageManager.saveGoal(newGoal)
        }
    }
    
    func setupEditScreen() {
        if currentGoal != nil {

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = DateFormatter.Style.none
            dateFormatter.timeStyle = DateFormatter.Style.short
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            
            let fromTimeStr: String? = currentGoal.fromTime
            let toTimeStr: String? = currentGoal.toTime

            guard let from = fromTimeStr, let to = toTimeStr else { return }
            let fromTime = dateFormatter.date(from: from)
            let toTime = dateFormatter.date(from: to)
            
            let firstPickerSelectedRow = firstPickerContent.firstIndex(of: currentGoal.countOfTimesInWeek) ?? 0
            print(firstPickerSelectedRow)
            let secondPickerSelectedRow = secondPickerContent.firstIndex(of: currentGoal.countOfTimesInString) ?? 0
            print(secondPickerSelectedRow)
            
            typeImage.image = UIImage(named: currentGoal.typeName)
            typeButton.setTitle(currentGoal.typeName, for: .normal)
            goalTitleTF.text = currentGoal.title
            minutesTF.text = String(currentGoal.timeIn)
            countOfMonthsTF.text = String(currentGoal.countOfMonth)
            firstPickerView.selectRow(firstPickerSelectedRow, inComponent: 0, animated: true)
            isTime = currentGoal.isTime
            timesTF.text = String(currentGoal.timesIn)
            howManyTF.text = String(currentGoal.countOfTimesIn)
            secondPickerView.selectRow(secondPickerSelectedRow, inComponent: 0, animated: true)
            isTimes = currentGoal.isTimes
            howMuchTF.text = String(currentGoal.countOfMoney)
            everyMonthTF.text = String(currentGoal.countOfMoneyEveryMonth)
            isSaveMoney = currentGoal.isSaveMoney
            firstFromDatePicker.date = fromTime!
            firstToDatePicker.date = toTime!
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section{
        case 0:
            switch indexPath.row {
            case 0:
                return 65
            case 1:
                return 80
            default:
                print("wrong in 0")
            }
        case 1:
            switch indexPath.row {
            case 0, 4, 8:
                return 44
            case 1, 2:
                if isTime { return 43.666} else { return 0 }
            case 3:
                if isTime { return 70} else { return 0 }
            case 5, 6:
                if isTimes { return 43.666} else { return 0 }
            case 7:
                if isTimes { return 70} else { return 0 }
            case 9, 10:
                if isSaveMoney { return 43.666} else { return 0 }
            default:
                print("wrong height in 1")
                return 100
            }
        case 2:
            switch indexPath.row{
            case 0:
                return 44
            case 1, 2:
                if isChooseButtonTapped { return 70 } else { return 0 }
            default:
                print("wrong at choose time")
            }
        case 3:
           return 44
        default:
            print("in global wrong")
            return 100
        }
        print("in method Wrong")
        return 20
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: Extensions

extension GoalDetailTVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension GoalDetailTVC: PickTypeDelegate {
    func pickType(type: String) {
        typeImage.image = UIImage(named: type)
        typeButton.setTitle(type, for: .normal)
    }
    
}

extension GoalDetailTVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return firstPickerContent.count
        } else {
            return secondPickerContent.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return "\(firstPickerContent[row])"
        } else {
            return "\(secondPickerContent[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            firstPickerChose = firstPickerContent[row]
        } else {
            secondPickerChose = secondPickerContent[row]
        }
        timesInPickerLabel.text = "How many times in \(secondPickerChose)?"
    }
}




