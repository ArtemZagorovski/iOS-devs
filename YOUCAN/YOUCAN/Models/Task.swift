//
//  Task.swift
//  YOUCAN
//
//  Created by Артем  on 3/30/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var taskDescription: String?
    @objc dynamic var timeInterval: String?
    @objc dynamic var isImportant = false
    @objc dynamic var isDone = false
    
    convenience init(title: String, taskDescription: String?, timeInterval: String?, important: Bool) {
        self.init()
        
        self.title = title
        self.taskDescription = taskDescription
        self.timeInterval = timeInterval
        self.isImportant = important
    }
}
