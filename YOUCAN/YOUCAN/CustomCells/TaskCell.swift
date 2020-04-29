//
//  TaskCell.swift
//  YOUCAN
//
//  Created by Артем  on 3/30/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var timeIntervalLabel: UILabel!
    @IBOutlet weak var importanseLabel: UILabel!
    
    @IBOutlet weak var isDoneButton: UIButton!
    
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        
    }
}
