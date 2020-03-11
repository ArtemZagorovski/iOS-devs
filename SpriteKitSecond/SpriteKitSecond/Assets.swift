//
//  Assets.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/29/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import SpriteKit

class Assets {

    static let shared = Assets()
    let yellowAmmoAtlas = SKTextureAtlas(named: "YellowAmmo")
    let enemy_1Atls = SKTextureAtlas(named: "Enemy_1")
    let enemy_2Atlas = SKTextureAtlas(named: "Enemy_2")
    let bluePowerUpAtlas = SKTextureAtlas(named: "BluePowerUp")
    let greenPowerUpAtlas = SKTextureAtlas(named: "GreenPowerUp")
    let playerPlaneAtlas = SKTextureAtlas(named: "PlayerPlane")
    
    func preloadAssets() {
        yellowAmmoAtlas.preload {}
        enemy_1Atls.preload {}
        enemy_2Atlas.preload {}
        bluePowerUpAtlas.preload {}
        greenPowerUpAtlas.preload {}
        playerPlaneAtlas.preload {}
    }
}
