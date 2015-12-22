//
//  GameScene.swift
//  FirstGame
//
//  Created by Esa Serog on 6/2/15.
//  Copyright (c) 2015 esaSerog. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var movingGround: ESMovingGround!
    var movingCieling: ESMovingGround!
    var player: ESSpaceship!
    var backgroundMusicPlayer : AVAudioPlayer!
    var PLAYER_STARTING_POINT : CGPoint!
    var isStarted = false
    
    //starting message
    let label = SKLabelNode(text: "Tap the screen to start!")
    
    //counter for num of touches
    var counter = 0
    
    //background music method
    /**
    * plays background music
    *
    */
    func playBackgroundMusic(filename: String)
    {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        if(url == nil)
        {
            print("Could not find file: \(filename)")
            return
        }//if
        
        
        //below is an example of the new try catch in swift 2!
        do {
        try backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: url!)
        } catch {
            print("Could not create audio player")
        }//catch
        
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }//playBackgroundMusic
    //DONE BACKGROUND MUSIC
    
    
    //blink animation for text
    /**
    * creates blinking animation for starting text label
    *
    *
    */
    func blinkAnimation() -> SKAction
    {
        let duration  = 0.6
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatActionForever(blink)
    }//blinkAnimation
    
    
    
    //START SCENE
    override func didMoveToView(view: SKView)
    {
        
        //label stuff
        label.position.x = view.center.x
        label.position.y = view.center.y
        label.fontName = "TimesNewRomanPS-BoldItalicMT"
        label.fontColor = UIColor.whiteColor()
        label.runAction(blinkAnimation()) //runs the blink animation forever
        
        //add physics to world
        self.physicsWorld.gravity = CGVectorMake(0, -3.5)
        
        
        //play background music
        playBackgroundMusic("bg_music.mp3")
        
        //create background
        backgroundColor = UIColor.blackColor() //TODO: maybe add an image to the background to give it a space feel
        movingGround = ESMovingGround(size: CGSizeMake(view.frame.width, 20))
        movingCieling = ESMovingGround(size: CGSizeMake(view.frame.width, view.frame.height/15))
        
        //set the position of the ground
        movingGround.position = CGPointMake(0, 0)
        movingCieling.position = CGPointMake(0, view.frame.height - movingCieling.frame.height)
        
        //addphysics to moving ground
        movingGround.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(view.frame.width, movingGround.size.height * 2))
        movingGround.physicsBody?.dynamic = false
        movingCieling.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(view.frame.width, movingCieling.size.height/2))
        movingCieling.physicsBody?.dynamic = false
        
        
        //create and position the player right above the ground
        player = ESSpaceship()
        player.position = CGPointMake(70, view.frame.height/2.0 /*- player.frame.size.height/2*/)
        PLAYER_STARTING_POINT = player.position
        
        
        
        
        
        
        
        //add the objects to the scene
        addChild(movingGround)
        addChild(label)
        addChild(player)
        addChild(movingCieling)
    }//didMoveToView
    
    
    
    
    //TODO: finish this method
    func reset()
    {
        player.position = PLAYER_STARTING_POINT
    }//reset
    
    
    
    
    
    
    
    
    //when touches begin
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        //increment touch counter every time screen is touched
        counter++
        
        //things to do on first touch
        if counter == 1{
            //adding the physics body here makes it so that the player doesn't automatically drop when the view starts
            player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
            player.physicsBody?.dynamic = true
            player.physicsBody?.allowsRotation = true
            label.hidden = true
        }//if
        if counter > 1
        {
            player.physicsBody?.velocity = CGVectorMake(0.0, 0.0)

            player.physicsBody?.applyImpulse(CGVectorMake(0, 15))
        }
        
        if counter == 5
        {
            backgroundMusicPlayer.stop()
            playBackgroundMusic("game_over.mp3")
        }
        
        
    }//touches began function
    
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }//update
        
}//class

