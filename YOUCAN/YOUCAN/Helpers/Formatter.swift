//
//  Formatter.swift
//  YOUCAN
//
//  Created by Артем  on 4/14/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import UIKit

struct Formatter {

    static let dateFormatter = DateFormatter()

    static func getStringFromDate(date: Date) -> String {
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter.string(from: date)
    }
    
    static func getDateFromString(stringDate: String) -> Date {
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        return dateFormatter.date(from: stringDate)!
    }
    
    static func getdateFromStringDateNone(stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: stringDate)!
    }
    
    static func getStringWithWeekDay(date: Date) -> String {
        dateFormatter.dateFormat = "EEEE, MMMM dd"
        return dateFormatter.string(from: date)
    }
    
}
