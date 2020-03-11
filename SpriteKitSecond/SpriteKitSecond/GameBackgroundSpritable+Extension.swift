//
//  GameBackgroundSpritable+Extension.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/27/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit
import GameplayKit

protocol GameBackgroundSpriteable {
    static func populate(at point: CGPoint?) -> Self
    static func randomPoint() -> CGPoint
}

extension GameBackgroundSpriteable {
    static func randomPoint() -> CGPoint {
        let screen = UIScreen.main.bounds
        let distribution = GKRandomDistribution(lowestValue: Int(screen.size.height + 400), highestValue: Int(screen.size.height + 500))
        let y = CGFloat(distribution.nextInt())
        let x = CGFloat(GKRandomSource.sharedRandom().nextInt(upperBound: Int(screen.size.width)))
        
        return CGPoint(x: x, y: y)
    }
}
