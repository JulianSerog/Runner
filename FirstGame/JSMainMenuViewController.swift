//
//  MainMenuViewController.swift
//  FirstGame
//
//  Created by Esa Serog on 10/19/15.
//  Copyright © 2015 esaSerog. All rights reserved.
//

import UIKit
import AVFoundation

class JSMainMenuViewController: UIViewController {
    
    //create variables and constants
    let startButton = UIButton(type: UIButtonType.custom) //make custom instead of system because button will be blue
    let logo = UIImageView(image: UIImage(named: "game-logo.png"))
    let backgroundImage = UIImageView()
    let buttonImage = UIImage(named: "start.png")
    //var isStarted: Bool = false
    var backgroundMusicPlayer : AVAudioPlayer!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addUI()
    }//viewWillAppear
    
    
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
    
    
    func addUI() {
        
        //bg music
        playBackgroundMusic("Game-Menu.mp3")
        
        
        // 1) bg image
        backgroundImage.image = UIImage(named: "game-bg2.png")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        backgroundImage.alpha = 1.0
        
        // 2)Game Title
        //titleLabel.text = "Star Racer"
        
        logo.frame = CGRect(x: view.frame.width * 0.2, y: view.frame.height * 0.2, width: view.frame.width * 0.6, height: view.frame.height * 0.1)

        
        // 3)start button
        startButton.setImage(buttonImage, for: UIControlState())
        startButton.frame = CGRect(x: view.frame.width/2 - view.frame.width * 0.15, y: view.frame.height * 0.6, width: view.frame.width * 0.30, height: view.frame.height * 0.30)
        startButton.addTarget(self, action: #selector(JSMainMenuViewController.startButtonPressed), for: UIControlEvents.touchUpInside)
        startButton.setTitleColor(UIColor.black, for: UIControlState())
        
        
        
        view.addSubview(logo)
        view.addSubview(startButton)
        view.addSubview(backgroundImage)
        view.sendSubview(toBack: backgroundImage)

        
    }//addUI
    
    
    func startButtonPressed() {
        
        /*
        //TODO: make create a new game and continue game button/function
        
        if(isStarted == false)
        {
            isStarted = true
        }//if
        */
        backgroundMusicPlayer.stop()
        performSegue(withIdentifier: "toGame", sender: self)
        
        
    }
    
    
    
}//MainMenuViewController
