//
//  BluePowerUp.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/29/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit


class BluePowerUp: PowerUp {
    
    init() {
        let textureAtlas = Assets.shared.bluePowerUpAtlas
        super.init(textureAtlas: textureAtlas)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
