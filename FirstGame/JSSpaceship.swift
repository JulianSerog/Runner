//
//  ESSpaceship.swift
//  FirstGame
//
//  Created by Esa Serog on 12/20/15.
//  Copyright © 2015 esaSerog. All rights reserved.
//

import Foundation
import SpriteKit


class ESSpaceship: SKSpriteNode {
    
    
    
    init()
    {
        let texture = SKTexture(imageNamed: "speedship.png")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        //setup physics
        physicsBody?.categoryBitMask = 0x1 << 0
    }//initializer
    
    
    
    
    
    func jump(var1: CGFloat)
    {
        //add if statement for jump checking in the start touches method
        let moveUp = SKAction.moveByX(0, y: var1, duration: 0.35);
        let moveDown = SKAction.moveByX(0, y: -1 * var1, duration: 0.175);
        let jumpSequence = SKAction.sequence([moveUp, moveDown])
        self.runAction(jumpSequence)
        print("Player jumped")
        
    }//jump
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }//required init
}//class
