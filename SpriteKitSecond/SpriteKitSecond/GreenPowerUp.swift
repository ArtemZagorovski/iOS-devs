//
//  GreenPowerUp.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/29/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit

class GreenPowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.greenPowerUpAtlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

