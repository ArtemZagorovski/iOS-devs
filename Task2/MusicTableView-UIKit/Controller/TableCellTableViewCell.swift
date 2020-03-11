//
//  TableCellTableViewCell.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
