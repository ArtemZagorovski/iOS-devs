//
//  Background.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/26/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit

class Background: SKSpriteNode {

    static func populatesBackground(at point: CGPoint) -> Background {
        
        let background = Background(imageNamed: "background")
        background.position = point
        background.zPosition = 0
        
        return background
        
    }
}
