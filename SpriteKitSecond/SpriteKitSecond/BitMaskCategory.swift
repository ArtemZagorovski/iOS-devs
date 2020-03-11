//
//  BitMaskCategory.swift
//  SpriteKitSecond
//
//  Created by Артем  on 2/29/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import Foundation


struct BitMaskCategory {
    static let player : UInt32  = 0x1 << 0    // 000000000000...01    1
    static let enemy : UInt32   = 0x1 << 1     // 000000000000...10    2
    static let powerUp : UInt32 = 0x1 << 2   // 000000000000..100    4
    static let shot : UInt32    = 0x1 << 3      // 000000000000.1000    8
}
