//
//  TaskExtension.swift
//  YOUCAN
//
//  Created by Артем  on 4/15/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

extension Task {

    // считает разницу между датами (в днях)
    func daysLeft() -> Int! {
        
        
        return (self.time.offsetFrom(date: Date().today))
    }
}

