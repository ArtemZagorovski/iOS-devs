//
//  APIManager.swift
//  YOUCAN
//
//  Created by Артем  on 4/16/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

protocol JSONDecodable {
  init?(JSON: [String: AnyObject])
}

enum APIResult<T> {
  case Success(T)
  case Failure(Error)
}

typealias JSONTask = URLSessionDataTask
typealias JSONCompletionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void


class APIManager {
    let urlbase = "https://api.darksky.net/forecast/586e691ba1bd5976b1cc3e6581f3c3e5/"
    
    func getWeatherData(coordinates: String, completionHandler: @escaping (APIResult<Weather>) -> Void){
        guard let url = URL(string: urlbase + coordinates) else { return }
        
        let request = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let HTTPResponse = response as? HTTPURLResponse else { return }
            
            switch HTTPResponse.statusCode {
            case 200:
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                    if let dictionary = json!["currently"] as? [String: AnyObject] {
                        completionHandler(.Success(Weather(JSON: dictionary)!))
                        print(dictionary)
                    } else {
                        return
                    }
                } catch let error as NSError {
                    print(error)
                }
            default:
                print("We have got response status \(HTTPResponse.statusCode)")
            }
        }
        dataTask.resume()
    }
}
