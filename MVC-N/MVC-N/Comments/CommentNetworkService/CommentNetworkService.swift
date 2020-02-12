//
//  CommentNetworkService.swift
//  MVC-N
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

class CommentNetworkServise {
    private init(){}
    
    static func getComments(completion: @escaping() -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments") else {return}
        
        NetworkService.shared.getData(url: url) {(json) in
            do{
                let response = try GetCommentResponse(json: json)
                completion(response)
            } catch {
                print(error)
            }
            
        }
    }
}
