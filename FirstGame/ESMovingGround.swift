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
class ESMovingGround: SKSpriteNode
{
    //declare constants
    let NUMBER_OF_SEGMENTS = 20
    let COLOR_ONE = UIColor(red: 0.2, green: 0.8, blue: 0.1, alpha: 1)
    let COLOR_TWO = UIColor(red: 0.4, green: 0.7, blue: 0.2, alpha: 1)
    
    //constructor
    init(size: CGSize)
    {
        super.init(texture: nil, color: UIColor.brownColor(), size: CGSizeMake(size.width*2, size.height))
        anchorPoint = CGPointMake(0, 0)
        
        for var i = 0; i < NUMBER_OF_SEGMENTS; i++
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
    
    
    
    
    
    
    //required code since we added a new initializer/constructor
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }//required init
}//class