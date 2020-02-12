//
//  GetCommentResponse.swift
//  MVC-N
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation

struct GetCommentResponse {
    typealias JSON = [String: AnyObject]
    let comments: [Comment]
    
    init(json: Any) throws {
        guard let array = json as? [JSON] else {throw NetworkError.failInternetError}
        
        var comments = [Comment]()
        
        for dictionary in array {
            guard let comment = Comment(dict: dictionary) else {continue}
            comments.append(comment)
        }
        self.comments = comments
    }
}
