//
//  DetailVC.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailToDoName: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var numberOfTask = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailToDoName.text = "Поручение № \(numberOfTask)"
        detailLabel.text = "Описание поручения № \(numberOfTask)"
        detailLabel.font = UIFont.systemFont(ofSize: 12)
        detailLabel.alpha = 0.7
        detailLabel.numberOfLines = 0
        
    }
}
