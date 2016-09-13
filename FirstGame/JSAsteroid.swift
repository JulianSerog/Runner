//
//  JSAsteroid.swift
//  Star Racer
//
//  Created by Esa Serog on 9/13/16.
//  Copyright © 2016 esaSerog. All rights reserved.
//

import SpriteKit

class JSAsteroid: SKSpriteNode {
    
    init(scene: GameScene) {
        super.init(texture: nil, color: SKColor.cyanColor(), size: CGSizeMake(scene.frame.width * 0.1, scene.frame.height * 0.1))
        position = CGPointMake(scene.frame.width * 0.9, scene.frame.height * 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
