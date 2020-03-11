//
//  CustomTableVC.swift
//  MyPlaces
//
//  Created by Артем  on 2/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import Cosmos

class CustomTableVC: UITableViewCell {

    @IBOutlet weak var imageOfPlace: UIImageView! {
        didSet {
            imageOfPlace.layer.cornerRadius =  imageOfPlace.frame.size.height / 2
            imageOfPlace.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var cosmosView: CosmosView! {
        didSet {
            cosmosView.settings.updateOnTouch = false
        }
    }
    
    
}
