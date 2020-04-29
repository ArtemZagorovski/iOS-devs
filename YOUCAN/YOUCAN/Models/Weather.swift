//
//  Weather.swift
//  YOUCAN
//
//  Created by Артем  on 4/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation
import UIKit

struct Weather {
  let temperature: Double
  let feelLikeTemp: Double
  let rain: String?
  let snow: String?
  let icon: UIImage
}

extension Weather: JSONDecodable {
  init?(JSON: [String : AnyObject]) {
    guard let temperature = JSON["temperature"] as? Double,
    let apparentTemperature = JSON["apparentTemperature"] as? Double,
      let iconString = JSON["icon"] as? String else {
        return nil
    }
    
    let icon = WeatherIconManager(rawValue: iconString).image
    
    self.temperature = temperature
    self.feelLikeTemp = apparentTemperature
    self.icon = icon
    self.rain = "no"
    self.snow = "no"
  }
}

extension Weather {
  var temperatureString: String {
    return "\(Int(5 / 9 * (temperature - 32)))˚C"
  }
  
  var feelLikeTempString: String {
    return "Feels like: \(Int(5 / 9 * (feelLikeTemp - 32)))˚C"
  }
}
