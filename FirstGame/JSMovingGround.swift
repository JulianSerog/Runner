//
//  ESMovingGround.swift
//  FirstGame
//
//  Created by Esa Serog on 6/2/15.
//  Copyright (c) 2015 esaSerog. All rights reserved.
//

import Foundation
import SpriteKit

/**
*   moving ground class
*   when we click, our ground starts to move
*
*/
class JSMovingGround: SKSpriteNode
{
    //declare constants
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor.redColor()
    let COLOR_TWO = UIColor.redColor()
    
    //constructor
    init(size: CGSize)
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0, 0)
        
        for i in 0 ..< NUMBER_OF_SEGMENTS
        {
            //the explanation point basically means that we promise we are going to initialize this color later on
            var segmentColor: UIColor!
            if i%2 == 0 {
                segmentColor = COLOR_ONE
            }//if
            else {
                segmentColor = COLOR_TWO
            }//else
            
            let segment = SKSpriteNode(color:segmentColor, size: CGSizeMake(self.size.width / CGFloat(NUMBER_OF_SEGMENTS), self.size.height ))
            segment.anchorPoint = CGPointMake(0.0, 0)
            segment.position = CGPointMake(CGFloat(i)*segment.size.width, 0)
            addChild(segment)
        }//for
    }//initializer/constructor
    
    
    func start(){
        let resetPosition = SKAction.moveToX(0, duration: 0)
        let moveLeft = SKAction.moveByX(-frame.size.width/2, y: 0, duration: 1.0)
        let moveSequence = SKAction.sequence([moveLeft,resetPosition])
        runAction(SKAction.repeatActionForever(moveSequence))
    }
    
    func stop()
    {
        self.removeAllActions()
    }
    
    
    
    
    
    
    //required code since we added a new initializer/constructor
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }//required init
}//class


//TODO: fix some of the wierd things going on with the ground/cieling running out when pausing the game