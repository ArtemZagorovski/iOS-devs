//
//  Enemy.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/28/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {

    static var textureAtlas: SKTextureAtlas?
    var enemyTexture: SKTexture!
    
    init(enemyTexture: SKTexture) {
        let texture = enemyTexture
        super.init(texture: texture, color: .clear, size: CGSize(width: 221, height: 204))
        self.xScale = 0.5
        self.yScale = -0.5
        self.zPosition = 20
        self.name = "sprite"
        
        self.physicsBody = SKPhysicsBody(texture: texture, alphaThreshold: 0.5, size: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = BitMaskCategory.enemy
        self.physicsBody?.collisionBitMask = BitMaskCategory.player | BitMaskCategory.shot
        self.physicsBody?.contactTestBitMask = BitMaskCategory.player | BitMaskCategory.shot
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func flySpiral() {
        
        let screenSize = UIScreen.main.bounds
        
        let timeHorizontal: Double = 3
        let timeVerticle: Double = 5
        
        let moveLeft = SKAction.moveTo(x: 50, duration: timeHorizontal)
        moveLeft.timingMode = .easeInEaseOut
        let moveright = SKAction.moveTo(x: screenSize.width - 50, duration: timeHorizontal)
        moveright.timingMode = .easeInEaseOut
        let randomNumber = Int(arc4random_uniform(2))
        
        let asideMoveSequence = randomNumber == EnemyDirection.left.rawValue ? SKAction.sequence([moveLeft, moveright]) : SKAction.sequence([moveright, moveLeft])
        
        let foreverAsideMovement = SKAction.repeatForever(asideMoveSequence)
        
        let forwardMovement = SKAction.moveTo(y: -105, duration: timeVerticle)
        let groupMovement = SKAction.group([foreverAsideMovement, forwardMovement])
        self.run(groupMovement)
    }
}


enum EnemyDirection: Int {
    case left = 0
    case right
}
