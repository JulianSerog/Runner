//
//  JSAsteroid.swift
//  Star Racer
//
//  Created by Esa Serog on 9/13/16.
//  Copyright © 2016 esaSerog. All rights reserved.
//

import SpriteKit

class JSAsteroid: SKSpriteNode {
    
    var xSpeed : Double = 15.0
    var moveLeft: SKAction!
    
    
    init(scene: GameScene, position: CGPoint) {
        let texture = SKTexture(imageNamed: "asteroid.png")
        super.init(texture: texture, color: UIColor.clear, size: CGSize(width: scene.frame.width * 0.1, height: scene.frame.width * 0.1))
        self.position = position
        physicsBody = SKPhysicsBody(texture: texture, size: self.size)
        //physics setup
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = 0x1 << 1
        physicsBody?.contactTestBitMask = 0x1 << 0
        //instiantiate moveLeft SKAction object
    }
    
    func move() {
        moveLeft = SKAction.moveBy(x: -1.5 * (scene?.frame.width)!, y:0, duration:xSpeed)
        self.run(moveLeft)
    }
    
    func stop() {
        self.removeAllActions()
    }
    
    func resume() {
        self.move()
    }
    
    func resetPos(scene: GameScene) {
        if(position.x + size.width < 0) {
            position.x = scene.frame.width
            stop()
            move() //TODO: temporary, make speed constant with slow updates to speed
        }//if
    }//resetPos
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
