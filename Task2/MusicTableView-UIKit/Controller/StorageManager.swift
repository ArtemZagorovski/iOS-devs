//
//  StorageManager.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/25/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ car: Car) {
        
        try! realm.write {
            realm.add(car)
        }
    }
    
    static func deliteObject (_ car: Car) {
        try! realm.write {
            realm.delete(car)
        }
    }
}
