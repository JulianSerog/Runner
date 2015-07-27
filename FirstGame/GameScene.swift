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
    var player: ESPlayer!
    var backgroundMusicPlayer : AVAudioPlayer!
    var PLAYER_STARTING_POINT : CGPoint!
    var isStarted = false
    
    //starting message
    let label = SKLabelNode(text: "Tap the screen to start!")
    
    
    //counter for num of touches
    var counter = 0
    
    //background music method
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
    
    
    
    //function that returns an SKAction
    func blinkAnimation() -> SKAction
    {
        let duration  = 0.6
        let fadeOut = SKAction.fadeAlphaTo(0.0, duration: duration)
        let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatActionForever(blink)
    }
    
    
    
    //Starting screen
    override func didMoveToView(view: SKView)
    {
        
        //label stuff
        label.position.x = view.center.x
        label.position.y = view.center.y
        label.fontName = "TimesNewRomanPS-BoldItalicMT"
        label.fontColor = UIColor.blackColor()
        label.runAction(blinkAnimation()) //runs the blink animation forever
        
        
        
        //play background music
        playBackgroundMusic("bg_music.mp3")
        
        
        
        
        //create background
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        movingGround = ESMovingGround(size: CGSizeMake(view.frame.width, 20))
        //set the position of the ground
        //set to 0 for ground or frame.height/2 for middle of screen
        movingGround.position = CGPointMake(0, 0)
        
        
        
        
        //create and position the player right above the ground
        player = ESPlayer()
        player.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height + player.frame.size.height/2)
        PLAYER_STARTING_POINT = player.position
        player.breathe()
        
        
        
        
        
        //add the objects to the scene
        addChild(movingGround)
        addChild(label)
        addChild(player)
        
        
    }//didMoveToView
    
    
    
    func reset()
    {
        player.position = PLAYER_STARTING_POINT
    }
    
    
    
    
    
    
    
    
    //when touches begin
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        
        //increment touch counter every time screen is touched
        counter++
        
        //things to do on first touch
        if counter == 1{
            player.stop()
            movingGround.start()
            player.startRunning()
            label.hidden = true
        }//if
        if counter > 1
        {
            print("Player starting height: \(PLAYER_STARTING_POINT)")
            if ((player.position.y > PLAYER_STARTING_POINT.y - 0.02) && (player.position.y < PLAYER_STARTING_POINT.y + 0.02))
            {
                //commented out b/c it's causing some strange issues with player's feet flying up
                //TODO -- create a function that stops the player from running and returns his arm to the initial spot
                //player.stop()
                player.jump((view?.frame.height)!/2)
                //player.startRunning()
                
            }//if player is at initial height
            print("Player Height now: \(player.position)")
        }
        
        //TEMPORARY ---- this is a placeholder until I add a jump, and collide mechanism with bricks
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