//
//  GoalCell.swift
//  YOUCAN
//
//  Created by Артем  on 4/1/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var iconOfGoal: UIImageView!
    @IBOutlet weak var titleOfGoal: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var percentOfGoal: UILabel!
    @IBOutlet weak var doItButton: UIButton!
    
    @IBAction func doItButtonTapped(_ sender: UIButton) {

    }
}
