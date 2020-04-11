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
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2,
                       delay: 0.1,
                       options: .curveLinear,
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            sender.isSelected = !sender.isSelected
        }) {(succes) in
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveLinear, animations: {
                sender.transform = .identity
            }, completion: nil)
        }
    }
}
