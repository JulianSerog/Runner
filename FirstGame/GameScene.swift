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
    
    //starting message
    var label = UILabel(frame: CGRectMake(0, 0, 200, 21))
    
    
    
    
    
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
        label.center = CGPointMake(frame.width/2, frame.height/2)
        label.text = "Touch the screen to play!"
        
        //try changing the font
        //label.font = UIFont(name: "cursive", size: 8)
        //print("couldn't find font!")
    
        self.view?.addSubview(label)
        
        
        playBackgroundMusic("bg_music.mp3")
        
        backgroundColor = UIColor(red: 159.0/255.0, green: 201.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        
        movingGround = ESMovingGround(size: CGSizeMake(view.frame.width, 20))
        //set the position of the ground
        //set to 0 for ground or frame.height/2 for middle of screen
        movingGround.position = CGPointMake(0, 0)
        //add the ground to the scene
        addChild(movingGround)
        
        
        player = ESPlayer()
        //positions the player right above the ground
        player.position = CGPointMake(70, movingGround.position.y + movingGround.frame.size.height + player.frame.size.height/2)
        addChild(player)
        player.breathe()
        
    }//didMoveToView
    
    
    
    
    
    
    
    
    //when touches begin
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        counter++
        if counter == 1{
            player.stop()
            movingGround.start()
            player.startRunning()
            label.hidden = true
        }//if
        if counter > 1 {
            player.stop()
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
