//
//  Coordinates.swift
//  YOUCAN
//
//  Created by Артем  on 4/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

enum Coordinates: String {
    case Minsk = "53.9 27.56667"
    case Moscow = "55.75 37.61"
    case Spb = "59.93 30.31"
    case NotFound
    
    init(rawValue: String) {
      switch rawValue {
      case "Minsk": self = .Minsk
      case "Moscow": self = .Moscow
      case "Spb": self = .Spb
      default: self = .NotFound
      }
    }
}
