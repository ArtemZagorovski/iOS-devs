//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Артем  on 2/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
        
        try! realm.write {
            realm.add(place)
        }
    }
    
    static func deliteObject (_ place: Place) {
        try! realm.write {
            realm.delete(place)
        }
    }
}
