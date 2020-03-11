//
//  Cloud.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/26/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit
import GameplayKit



final class Cloud: SKSpriteNode, GameBackgroundSpriteable {

    static func populate(at point: CGPoint?) -> Cloud {
        let cloudImageName = configureName()
        let cloud = Cloud(imageNamed: cloudImageName)
        cloud.setScale(randomScaleFactor)
        cloud.position = point ?? randomPoint()
        cloud.name = "sprite"
        cloud.anchorPoint = CGPoint(x: 0.5, y: 1.0 )
        cloud.zPosition = 10
        cloud.run(move(from: cloud.position))
        
        return cloud
    }
    
    fileprivate static func configureName() -> String {
        let distribution = GKRandomDistribution(lowestValue: 1, highestValue: 3)
        let randomNumber = distribution.nextInt()
        let imageName = "cl\(randomNumber)"
        
        return imageName
    }
    
    static var randomScaleFactor: CGFloat {
        let distribution = GKRandomDistribution(lowestValue: 20, highestValue: 30)
        let randomNumber = CGFloat(distribution.nextInt()) / 10
        
        return randomNumber
    }
    
    fileprivate static func move(from point: CGPoint) -> SKAction {
        let movePoint = CGPoint(x: point.x, y: -200)
        let moveDistance = point.y + 200
        let moveSpeed: CGFloat = 150.0
        let moveDuration = moveDistance / moveSpeed
        
        return SKAction.move(to: movePoint, duration: TimeInterval(moveDuration))
    }
    
}
