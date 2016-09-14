//
//  MainMenuViewController.swift
//  FirstGame
//
//  Created by Esa Serog on 10/19/15.
//  Copyright © 2015 esaSerog. All rights reserved.
//

import UIKit

class JSMainMenuViewController: UIViewController
{
    
    //create variables and constants
    let startButton = UIButton(type: UIButtonType.custom) //make custom instead of system because button will be blue
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    let buttonImage = UIImage(named: "start.png")
    //var isStarted: Bool = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addUI()
    }//viewWillAppear
    
    
    func addUI() {
        
        // 1) bg image
        backgroundImage.image = UIImage(named: "space.jpg")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        backgroundImage.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        backgroundImage.alpha = 1.0
        
        // 2)Game Title
        titleLabel.text = "Star Racer"
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.20)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        //titleLabel.backgroundColor = UIColor.clearColor()
        
        // 3)start button
        startButton.setImage(buttonImage, for: UIControlState())
        startButton.frame = CGRect(x: view.frame.width/2 - view.frame.width * 0.15, y: view.frame.height/2 - view.frame.height * 0.15, width: view.frame.width * 0.30, height: view.frame.height * 0.30)
        startButton.addTarget(self, action: #selector(JSMainMenuViewController.startButtonPressed), for: UIControlEvents.touchUpInside)
        startButton.setTitleColor(UIColor.black, for: UIControlState())
        
        
        
        view.addSubview(titleLabel)
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
        performSegue(withIdentifier: "toGame", sender: self)
        
        
    }
    
    
    
}//MainMenuViewController
