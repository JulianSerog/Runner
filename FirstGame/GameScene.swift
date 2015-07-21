//
//  GameScene.swift
//  FirstGame
//
//  Created by Esa Serog on 6/2/15.
//  Copyright (c) 2015 esaSerog. All rights reserved.
//

import SpriteKit
import AVFoundation

class GameScene: SKScene {
    
    var movingGround: ESMovingGround!
    var player: ESPlayer!
    var backgroundMusicPlayer : AVAudioPlayer!
    
    var counter = 0
    
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
    
    override func didMoveToView(view: SKView)
    {
        /* Setup your scene here */
        
        playBackgroundMusic("bg_music.mp3")
        
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        movingGround = ESMovingGround(size: CGSizeMake(view.frame.width, 20))
        //set the position of the ground
        //set to 0 for ground or frame.height/2 for middle of screen
        movingGround.position = CGPointMake(0, 0 /* view.frame/2 */)
        //add the ground to the scene
        addChild(movingGround)
        
        
        player = ESPlayer()
        //positions the player right above the ground
        player.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height + player.frame.size.height/2)
        addChild(player)
        player.breathe()
        
        
    }//didMoveToView
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        counter++
        if counter == 1{
            player.stop()
            movingGround.start()
            player.startRunning()
        }//if
        if counter > 1 {
            player.stop()
        }
        
     
    }//touches began function
   
    override func update(currentTime: CFTimeInterval)
    {
        /* Called before each frame is rendered */
    }//update
}//class
