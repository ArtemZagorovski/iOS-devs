//
//  NetworkService.swift
//  MVC-N
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class NetworkService {
    
    private init() {}
    
    static let shared = NetworkService()
    
    public func getData (url: URL, complition: @escaping (Any) -> ()) {
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print (error)
            }
        }.resume()
        
    }
}
