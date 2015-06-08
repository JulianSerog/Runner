//
//  ESPlayer.swift
//  FirstGame
//
//  Created by Esa Serog on 6/3/15.
//  Copyright (c) 2015 esaSerog. All rights reserved.
//

import Foundation
import SpriteKit
//extension of a sprite node
class ESPlayer: SKSpriteNode {
    
    var body: SKSpriteNode!
    var arm: SKSpriteNode!
    var leftFoot: SKSpriteNode!
    var rightFoot: SKSpriteNode!
    //override?

    init() {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(32, 44))
        //body
        body = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(self.frame.size.width, 40))
        body.position = CGPointMake(0, 2)
        
        
        //create face
        let skinColor = UIColor(red: 1.0, green: 0.8, blue: 0.7, alpha: 1.0)
        let face = SKSpriteNode(color: skinColor, size: CGSizeMake(self.frame.size.width, 12))
        face.position = CGPointMake(0, 6)
        
        
        let eyeColor = UIColor.whiteColor()
        let leftEye = SKSpriteNode(color: eyeColor, size: CGSizeMake(6,6))
        let rightEye = leftEye.copy() as! SKSpriteNode
        let pupil = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(3, 3))
        
        pupil.position = CGPointMake(2, 0)
        leftEye.addChild(pupil)
        leftEye.position = CGPointMake(-4, 0)
        rightEye.position = CGPointMake(14, 0)
        
        let mouth = SKSpriteNode(color: UIColor.blackColor(), size: CGSizeMake(11, 1))
        mouth.position = CGPointMake(0, (leftEye.size.height/2) - 1.5)
        
        let eyebrow = SKSpriteNode(color: UIColor.brownColor(), size: CGSizeMake(8, 1))
        eyebrow.position = CGPointMake(-1, leftEye.size.height/2)
        
        
        //add children
        addChild(body)
        body.addChild(face)
        rightEye.addChild(pupil.copy() as! SKSpriteNode)
        face.addChild(leftEye)
        face.addChild(rightEye)
        body.addChild(mouth)
        leftEye.addChild(eyebrow)
        rightEye.addChild(eyebrow.copy() as! SKSpriteNode)
        
        //arm
        let armColor = UIColor(red: 46/255, green: 46/255, blue: 46/255, alpha: 1)
        arm = SKSpriteNode(color: armColor, size: CGSizeMake(8, 14))
        //anchor point is used for rotation
        arm.anchorPoint = CGPointMake(0.5, 0.9)
        arm.position = CGPointMake(-10,-7)
        
        let hand = SKSpriteNode(color: skinColor, size: CGSizeMake(arm.size.width, 5))
        hand.position = CGPointMake(0, -arm.size.height*0.9 + hand.size.height/2)
        
        
        body.addChild(arm)
        arm.addChild(hand)
        
        //feet
        leftFoot = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(9, 4))
        leftFoot.position = CGPointMake(-6, -size.height/2 + leftFoot.size.height/2)
        rightFoot = leftFoot.copy() as! SKSpriteNode
        rightFoot.position.x = 8
        
        addChild(leftFoot)
        addChild(rightFoot)
    }//initializer
    
    
    func breathe() {
        let breatheOut = SKAction.moveByX(0, y: -2, duration: 1)
        let breatheIn = SKAction.moveByX(0, y: 2, duration: 1)
        let breath = SKAction.sequence([breatheOut,breatheIn])
        body.runAction(SKAction.repeatActionForever(breath))
    }//breathe
    
    func
        startRunning() {
        let rotateBack = SKAction.rotateByAngle(-CGFloat(M_PI)/2.0, duration: 0.1)
        arm.runAction(rotateBack)
            
        performOneRunCycle()
    }
    
    
    func performOneRunCycle() {
        let up = SKAction.moveByX(0, y: 2, duration: 0.05)
        let down = SKAction.moveByX(0, y: -2, duration: 0.05)
        
        leftFoot.runAction(up, completion: { () -> Void in
            self.leftFoot.runAction(down)
            self.rightFoot.runAction(up, completion: { () -> Void in
                self.rightFoot.runAction(down, completion: { () -> Void in
                    self.performOneRunCycle()
                })
            })
        })
    }
    
    
    func jump() {
        
    }//jump
    
    func stop() {
        body.removeAllActions()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }//required init
}//class





//LAST THINGS TO DO -- CHANGE CLOTHES
