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
    var PLAYER_STARTING_HEIGHT : CGPoint!
    
    //starting message
    var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
    
    
    //enums
    enum BodyType: UInt32 {
        case ESPlayer = 1
        case ESMovingGround = 2
        case anotherBody1 = 4
        case anotherBody2 = 8
        case anotherBody3 = 16
    }
    
    
    
    
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
    
    
    
    
    
    
    //Starting screen
    override func didMoveToView(view: SKView)
    {
        //show physics
        view.showsPhysics = true
        
        
        label.center = CGPointMake(frame.width/2, frame.height/2)
        label.text = "Touch the screen to play!"
        
        //try changing the font
        //label.font = UIFont(name: "cursive", size: 8)
        //print("couldn't find font!")
        
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
        PLAYER_STARTING_HEIGHT = player.position
        player.breathe()
        
        

        
        
        //add the objects to the scene
        addChild(movingGround)
        self.view?.addSubview(label)
        addChild(player)

        
    }//didMoveToView
    
    
    
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        //called automatically when two objects begin contact with each other
    }//didBeginContact
    
    func didEndContact(contact: SKPhysicsContact)
    {
        //gets called automatically when two objects end contact
    }//didEndContact
    
    
    
    
    
    
    
    
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
            print("Player starting height: \(PLAYER_STARTING_HEIGHT)")
            if ((player.position.y > PLAYER_STARTING_HEIGHT.y - 0.02) && (player.position.y < PLAYER_STARTING_HEIGHT.y + 0.02))
            {
                //commented out b/c it's causing some strange issues with player's feet flying up
                //player.stop()
                player.jump((view?.frame.height)!/2)
                //player.startRunning()
                
            }//if player is at initial height
            print("Player Height now: \(player.position)")
        }
        
        //TEMPORARY ---- this is a placeholder until I add a jump, and collide mechanism with bricks
        if counter == 3
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
