//
//  Goal.swift
//  YOUCAN
//
//  Created by Артем  on 4/1/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import RealmSwift


class Goal: Object {
    
    @objc dynamic var typeName = ""
    @objc dynamic var title = ""
    
    @objc dynamic var timeIn = 0
    @objc dynamic var countOfMonth = 0
    @objc dynamic var countOfTimesInWeek = "Every day"
    @objc dynamic var isTime: Bool = false
    
    @objc dynamic var timesIn = 0
    @objc dynamic var countOfTimesIn = 0
    @objc dynamic var countOfTimesInString = "Day"
    @objc dynamic var isTimes: Bool = false
    
    @objc dynamic var countOfMoney = 0
    @objc dynamic var countOfMoneyEveryMonth = 0
    @objc dynamic var isSaveMoney: Bool = false
    
    @objc dynamic var fromTime = ""
    @objc dynamic var toTime = ""
    @objc dynamic var isSecondTime: Bool = false
    
    @objc dynamic var startDate = Date()
    @objc dynamic var progress: Float = 0.0
    @objc dynamic var finalTask: Float = 0.0
    
    convenience init(typeName: String,
                     title: String,
                     timeIn: Int?,
                     countOfMonth: Int?,
                     countOfTimesInWeek: String?,
                     isTime: Bool,
                     timesIn: Int?,
                     countOfTimesIn: Int?,
                     countOfTimesInString: String?,
                     isTimes: Bool,
                     countOfMoney: Int?,
                     countOfMoneyEveryMonth: Int?,
                     isSaveMoney: Bool,
                     fromTime: String,
                     toTime: String,
                     finalTask: Float
        
                     
    ){
        
        self.init()
        
        self.typeName = typeName
        self.title = title
        self.timeIn = timeIn ?? 0
        self.countOfMonth = countOfMonth ?? 0
        self.countOfTimesInWeek = countOfTimesInWeek ?? "Every day"
        self.isTime = isTime
        self.timesIn = timesIn ?? 0
        self.countOfTimesIn = countOfTimesIn ?? 0
        self.countOfTimesInString = countOfTimesInString ?? "Day"
        self.isTimes = isTimes
        self.countOfMoney = countOfMoney ?? 0
        self.countOfMoneyEveryMonth = countOfMoneyEveryMonth ?? 0
        self.isSaveMoney = isSaveMoney
        self.fromTime = fromTime
        self.toTime = toTime
        self.finalTask = finalTask
    }
    
}
