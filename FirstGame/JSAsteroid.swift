//
//  JSAsteroid.swift
//  Star Racer
//
//  Created by Esa Serog on 9/13/16.
//  Copyright © 2016 esaSerog. All rights reserved.
//

import SpriteKit

class JSAsteroid: SKSpriteNode {
    
    var xSpeed : Double = -15.0
    
    init(scene: GameScene) {
        let texture = SKTexture(imageNamed: "asteroid.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: scene.frame.width * 0.1, height: scene.frame.width * 0.1))
        position = CGPoint(x: scene.frame.width * 0.9, y: scene.frame.height * 0.5)
        physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        //physics setup
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 0x1 << 1
        physicsBody?.contactTestBitMask = 0x1 << 0
    }
    
    func move() {
        //SKTransition.moveInWithDirection(.Left, duration: 5.0)
        print("asteroid moved")
        self.physicsBody?.applyImpulse(CGVector.init(dx: xSpeed, dy: 0.0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
