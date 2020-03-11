//
//  Car.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import RealmSwift


class Car: Object {
    
    @objc dynamic var brand = ""
    @objc dynamic var model: String?
    @objc dynamic var cost: Int = 0
    @objc dynamic var imageData: Data?
    
    convenience init(brand: String, model: String?, cost: Int?, imageData: Data?){
        self.init()
        self.brand = brand
        self.model = model
        self.cost = cost ?? 0
        self.imageData = imageData
    }
}
