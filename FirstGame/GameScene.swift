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
    
    //class/scene variables
    var ground: JSMovingGround!
    var ceiling: JSMovingGround!
    var player: ESSpaceship!
    var backgroundMusicPlayer : AVAudioPlayer!
    var PLAYER_STARTING_POINT : CGPoint!
    var isStarted = false
    let pauseButton: UIButton = UIButton(type: .custom)
    let replayButton: UIButton = UIButton(type: .custom)
    var isHit = false
    var bg : SKSpriteNode!
    var pause = false
    
    //NSUserDefaults for storage
    let defaults = UserDefaults.standard
    
    //TODO: create a label for high scores - use realm to save high score
    let highScoreLbl: SKLabelNode = SKLabelNode()
    
    let pauseImage = UIImage(named: "pause.png")
    let replayImage = UIImage(named: "reset.png")
    let playImage = UIImage(named: "play.png")
    
    //timer for keeping score & increasing difficulty
    var timer : Timer!
    var timer_value = 0
    let timeLabel = SKLabelNode()//TODO: change timer value to time

    
    //array of asteroids
    let asteroids : NSMutableArray = NSMutableArray()
    
    //TODO: change to gamescene?
    var viewController: UIViewController?
    
    //starting message
    let label = SKLabelNode(text: "Tap the screen to start!")
    
    //counter for num of touches
    var counter = 0
    
    //START SCENE
    override func didMove(to view: SKView) {
        //play background music
        playBackgroundMusic("game-bg.mp3")
        
        //MARK: setup world physics
        physicsWorld.contactDelegate = self
        addElementsAndUI()
    }//didMoveToView
    
    //gameSceneDidView above
    //==========================================================================================================================================//
    //==========================================================================================================================================//
    //more methods below
    
    
    
    // playBackgroundMusic
    func playBackgroundMusic(_ filename: String) {
        let url = Bundle.main.url(forResource: filename, withExtension: nil)
        if(url == nil)
        {
            print("Could not find file: \(filename)")
            return
        }//if
        
        
        //below is an example of the new try catch in swift 2!
        do {
            try backgroundMusicPlayer = AVAudioPlayer(contentsOf: url!)
        } catch {
            print("Could not create audio player")
        }//catch
        
        backgroundMusicPlayer.numberOfLoops = -1 //toSetInfiniteLoop
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
    }//playBackgroundMusic
    
    //TODO: finish this method
    func reset() {
        backgroundMusicPlayer.stop()
        replayButton.isHidden = true
        let gameScene = GameScene(size: self.size)
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        gameScene.scaleMode = SKSceneScaleMode.aspectFill
        self.scene!.view?.presentScene(gameScene, transition: transition)
    }//reset
    
    
    //MARK: addPhysicsToWorld
    func addPhysicsToWorld() {
        //add physics to world
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -3.5)
        //addphysics to moving ground
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: view!.frame.width, height: ground.size.height * 2))
        ground.physicsBody?.isDynamic = false
        ceiling.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: view!.frame.width, height: ceiling.size.height/2))
        ceiling.physicsBody?.isDynamic = false
        
        //add physics to ground and ceiling
        //physics setup
        //TODO: find out why this doesn't work in class
        ground.physicsBody?.categoryBitMask = 0x1 << 1
        ground.physicsBody?.contactTestBitMask = 0x1 << 0
        ceiling.physicsBody?.categoryBitMask = 0x1 << 1
        ceiling.physicsBody?.contactTestBitMask = 0x1 << 0
    }//addPhysicsToWorld
    

    // blink animation for label
    func blinkAnimation() -> SKAction {
        let duration  = 0.6
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut, fadeIn])
        return SKAction.repeatForever(blink)
    }//blinkAnimation
    
    // add elements and set up game
    func addElementsAndUI() {
        //add background -- background added through sprite
        bg = SKSpriteNode(imageNamed: "game-bg1.png")
        bg.size = CGSize(width: view!.frame.width, height:( view?.frame.height)!)
        bg.position = CGPoint(x: (view?.frame.width)!/2, y: view!.frame.height/2)
        
        //time
        timeLabel.text = "Score: \(calculateTime(time: timer_value))"
        timeLabel.position.x = self.frame.width * 0.8 //time label on right side of screen
        timeLabel.position.y = self.frame.height * 0.08 //time label on bottom of screen
        timeLabel.fontSize = 24.0   //adjust font size
        timeLabel.fontColor = UIColor.white //make font color white to see on background
        
        //high score
        highScoreLbl.text = "High Score: "
        highScoreLbl.position.y = self.frame.height * 0.08 //time label on bottom of screen
        highScoreLbl.position.x = self.frame.width * 0.15
        highScoreLbl.fontSize = 20.0   //adjust font size
        highScoreLbl.fontColor = UIColor.white //make font color white to see on background
        highScoreLbl.text = "High Score: \(calculateTime(time: getHighScore()))"

        
        //pause button
        pauseButton.frame = CGRect(x: (scene?.frame.width)! - (scene?.frame.width)! * 0.075, y: view!.frame.height - (view?.frame.height)! * 0.15, width: view!.frame.height * 0.08, height: view!.frame.height * 0.08)
        //make button circular
        pauseButton.layer.cornerRadius = 0.5 * pauseButton.bounds.size.width
        pauseButton.clipsToBounds = true
        pauseButton.backgroundColor = UIColor.white
        pauseButton.setBackgroundImage(pauseImage, for: .normal)
        pauseButton.tintColor = UIColor.clear
        pauseButton.addTarget(self, action: #selector(GameScene.pauseButtonPressed), for: UIControlEvents.touchUpInside)
        pauseButton.setTitleColor(UIColor.black, for: UIControlState())
        
        //add a replay button
        replayButton.frame = CGRect(x: (scene?.frame.width)! - (scene?.frame.width)! * 0.075, y: view!.frame.height - (view?.frame.height)! * 0.25, width: view!.frame.height * 0.08, height: view!.frame.height * 0.08)
        replayButton.layer.cornerRadius = 0.5 * replayButton.bounds.size.width
        replayButton.backgroundColor = UIColor.white
        replayButton.setBackgroundImage(replayImage, for: .normal)
        replayButton.setTitleColor(UIColor.black, for: UIControlState())
        replayButton.addTarget(self, action: #selector(self.reset), for: .touchUpInside)
        replayButton.tintColor = UIColor.clear
        
        //create and position the player right above the ground
        player = ESSpaceship()
        player.position = CGPoint(x: 70, y: view!.frame.height/2.0 /*- player.frame.size.height/2*/)
        PLAYER_STARTING_POINT = player.position
        
        //ground and ceiling
        ground = JSMovingGround(size: CGSize(width: view!.frame.width, height: 20))
        ceiling = JSMovingGround(size: CGSize(width: view!.frame.width, height: view!.frame.height/15))
        
        //set the position of the ground
        ground.position = CGPoint(x: 0, y: 0)
        ceiling.position = CGPoint(x: 0, y: view!.frame.height - ceiling.frame.height)
        
        asteroids.add(JSAsteroid(scene: self, position: CGPoint(x: (scene?.frame.width)! + (scene?.frame.width)! * 0.1/*asteriod width*/, y: (scene?.frame.height)! * 0.8)))
        
        //add physics
        addPhysicsToWorld()
        
        //label
        label.position.x = view!.center.x
        label.position.y = view!.center.y
        label.fontName = "TimesNewRomanPS-BoldItalicMT"
        label.fontColor = UIColor.white
        label.run(blinkAnimation()) //runs the blink animation forever

        //add the objects to the scene
        addChild(bg) //set to first so it is in the back of the view
        addChild(ground)
        addChild(highScoreLbl)
        addChild(timeLabel)
        addChild(label)
        addChild(player)
        addChild(ceiling)
        addChild(asteroids[0] as! SKNode)
        view!.addSubview(pauseButton)
    }//addElementsAndUI
    
    
    //MARK: touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        //increment touch counter every time screen is touched
        counter += 1
        //things to do on first touch
        if counter == 1 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(GameScene.incrementTime), userInfo: nil, repeats: true)
            
            //print("timer: \(timer)")
            
            //adding the physics body here makes it so that the player doesn't automatically drop when the view starts
            player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
            player.physicsBody?.isDynamic = true
            player.physicsBody?.allowsRotation = true
            label.isHidden = true
            //move all asteroids, should only be 1 at touches == 1
            for asteroid in asteroids {
                (asteroid as! JSAsteroid).move()
            }
        }//if
        if counter > 1 {
            player.physicsBody?.velocity = CGVector(dx: 0.0, dy: 0.0)
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 12.5))
        }//if
    }//touches began function
    
    
    //MARK: update
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        
        for asteroid in asteroids {
            (asteroid as! JSAsteroid).resetPos(scene: self)
        }
    }//update
    
    
    //MARK: did Begin Contact
    func didBegin(_ contact: SKPhysicsContact) {
        if isHit != true {
            isHit = true
            
            //save high score if it is higher than current score
            if(timer_value > getHighScore()) {
                saveHighScore()
            }
            
            backgroundMusicPlayer.stop()
            playBackgroundMusic("game_over.mp3")
            //show replay button
            view?.addSubview(replayButton)
            physicsWorld.gravity = CGVector.zero
            physicsWorld.speed = 0.0
            
            //label
            let failureLabel = SKLabelNode(text: "You failed!")
            failureLabel.position.x = view!.center.x
            failureLabel.position.y = view!.center.y
            failureLabel.fontName = "TimesNewRomanPS-BoldItalicMT"
            failureLabel.fontColor = UIColor.red
            addChild(failureLabel)
            failureLabel.run(blinkAnimation()) //runs the blink animation forever
            
            //halt all asteroids
            for asteriod in asteroids {
                (asteriod as! JSAsteroid).stop()
            }
        }//if
    }//didBeginContact
    

    //TODO: find out why segue isn't performing
    //MARK: pause button pressed
    func pauseButtonPressed() {
        if (pause == false && isHit == false && counter > 0) {
            pause = true
            //print(physicsWorld.speed) //to find current speed
            physicsWorld.speed = 0.0
            //performSegueWithIdentifier("toMainMenu", sender: self) //not available in SKScene
            pauseButton.setBackgroundImage(playImage, for: .normal)
            
            //halt all asteriods
            for asteriod in asteroids {
                (asteriod as! JSAsteroid).stop()
            }
            
            //print("entered pause, pause var is now:   \(pause)")
        } else if (pause == true && isHit == false) {
            pause = false
            
            //resume asteriods
            for asteriod in asteroids {
                (asteriod as! JSAsteroid).resume()
            }
            
            pauseButton.setBackgroundImage(pauseImage, for: .normal)
            physicsWorld.speed = 1.0 //resumes game
        } else if (pause == false && isHit == true) {
            //print("button pressed and is hit is true")
            //causes error
            //self.view!.window!.rootViewController!.performSegueWithIdentifier("toMainMenu", sender: self)
        }
    }//pauseButtonPressed
    
    //MARK: timer triggers this function, this is where extra asteroids get created and difficulty increases over time
    func incrementTime() {
        //only increments the timer when the game is not paused and the player is not hit
        if(!pause && !isHit) {
            raiseDifficulty()
            timer_value += 1
            timeLabel.text = "Score: \(calculateTime(time: timer_value))"
            if(timer_value == 5) {
                asteroids.add(JSAsteroid(scene: self, position: CGPoint(x: (scene?.frame.width)! + (scene?.frame.width)! * 0.1/*asteriod width*/, y: (scene?.frame.height)! * 0.23)))
                addChild((asteroids[1] as! JSAsteroid))
                (asteroids[1] as! JSAsteroid).move()
            } else if (timer_value == 7) {
                asteroids.add(JSAsteroid(scene: self, position: CGPoint(x: (scene?.frame.width)! + (scene?.frame.width)! * 0.1/*asteriod width*/, y: (scene?.frame.height)! * 0.5)))
                addChild((asteroids[2] as! JSAsteroid))
                (asteroids[2] as! JSAsteroid).move()
            }//else if
        }//if not pause
    }//incrementTime
    
    func raiseDifficulty() {
        if (timer_value == 20) {
            //increment speed
            for asteroid in asteroids {
                (asteroid as! JSAsteroid).xSpeed -= 2
            }
        } else if (timer_value == 40) {
            for asteroid in asteroids {
                (asteroid as! JSAsteroid).xSpeed -= 2
            }
        } else if (timer_value == 60) {
            for asteroid in asteroids {
                (asteroid as! JSAsteroid).xSpeed -= 2
            }
        } else if (timer_value == 80) {
            for asteroid in asteroids {
                (asteroid as! JSAsteroid).xSpeed -= 2
            }
        } else if (timer_value == 100) {
            for asteroid in asteroids {
                (asteroid as! JSAsteroid).xSpeed -= 2
            }
        }

    }//raise diffuculty
    
    func calculateTime(time: Int) -> String {
        let min = time / 60
        let sec = time % 60
        var minString: String
        var secString: String
        
        //format sub strings
        if(sec < 10) {
            secString = "0\(sec)"
        } else {
            secString = String(sec)
        }
        
        if(min < 10) {
            minString = "0\(min)"
        } else {
            minString = String(min)
        }
        
        
        let s = "\(minString):\(secString)"
        return s
    }
    
    func saveHighScore() {
        let dictionary = ["highScore" : timer_value]
        defaults.set(dictionary, forKey: "StarRacer")
    }
    
    func getHighScore() -> Int {
        if defaults.object(forKey: "StarRacer") == nil {
            defaults.set(["highScore":0], forKey: "StarRacer")
            
        }
        let highScoreDict: NSDictionary = defaults.object(forKey: "StarRacer") as! NSDictionary
        let highScore: Int = highScoreDict.object(forKey: "highScore") as! Int
        return highScore 
    }
    
}//class


//TODO: make an astroid/obstacle class and implement in main game
//TODO: make start screen & barriers less ugly
