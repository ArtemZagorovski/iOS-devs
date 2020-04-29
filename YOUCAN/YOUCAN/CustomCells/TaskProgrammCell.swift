//
//  GoalProgrammCell.swift
//  YOUCAN
//
//  Created by Артем  on 4/20/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class TaskProgrammCell: UITableViewCell {
    
    var task : Task? {
        didSet {
            guard let task = task else {
                titleLabel.alpha = 0.2
                descriptionLabel.alpha = 0.2
                datelabel.alpha = 0.2
                return
            }
            titleLabel.text = task.title
            descriptionLabel.text = task.taskDescription
            
            if !task.timeInterval!.isEmpty {
                        let diff = task.daysLeft()
                        let dateParts = task.timeInterval?.components(separatedBy: ", ")
                        switch diff {
                        case 0:
                            datelabel.text = "Today \n \(dateParts![1])"
                        case 1:
                            datelabel.text = "Tomorrow \n \(dateParts![1])"
                        //case ..<0:
            //                cell.timeIntervalLabel.alpha = 0.4
                        default:
                            datelabel.text = "\(Formatter.getStringWithWeekDay(date: task.time)) \n \(dateParts![1])"
                        }
                    } else {
                        datelabel.text = ""
                    }
                    
                    if task.isImportant {
                        importantLabel.backgroundColor = UIColor(named: "ImportantLabel")
                    } else {
                        importantLabel.backgroundColor = UIColor(named: "NormalLabel")
                    }
                    
                    if task.isDone{
                        checkButton.setImage(UIImage(named: "checked"), for: .normal)
                    } else {
                        checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
                    }
                    
        }
    }
    
    private let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Title"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "description"
        lbl.textColor = .black
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let checkButton : UIButton = {
        let check = UIButton()
        check.setImage(UIImage(named: "unchecked"), for: .normal)
        return check
    }()
    
    private let datelabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Date"
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let importantLabel : UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .lightGray
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(checkButton)
        addSubview(datelabel)
        addSubview(importantLabel)
        
        importantLabel.translatesAutoresizingMaskIntoConstraints = false
        importantLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        importantLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        importantLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        importantLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.leadingAnchor.constraint(equalTo: importantLabel.trailingAnchor, constant: 8).isActive = true
        checkButton.topAnchor.constraint(equalTo: topAnchor, constant: 19).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        checkButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
       
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: checkButton.trailingAnchor, constant: 8).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 17).isActive = true
        
        datelabel.translatesAutoresizingMaskIntoConstraints = false
        datelabel.topAnchor.constraint(equalTo: topAnchor, constant: 13).isActive = true
        datelabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        datelabel.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
