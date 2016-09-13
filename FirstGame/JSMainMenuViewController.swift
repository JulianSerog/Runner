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
    let startButton = UIButton(type: UIButtonType.Custom) //make custom instead of system because button will be blue
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    let buttonImage = UIImage(named: "start.png")
    //var isStarted: Bool = false
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addUI()
    }//viewWillAppear
    
    
    func addUI() {
        
        // 1) bg image
        backgroundImage.image = UIImage(named: "space.jpg")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImage.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        backgroundImage.alpha = 1.0
        
        // 2)Game Title
        titleLabel.text = "Star Racer"
        titleLabel.frame = CGRectMake(0, 0, view.frame.width, view.frame.height * 0.20)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        //titleLabel.backgroundColor = UIColor.clearColor()
        
        // 3)start button
        startButton.setImage(buttonImage, forState: UIControlState.Normal)
        startButton.frame = CGRectMake(view.frame.width/2 - view.frame.width * 0.15, view.frame.height/2 - view.frame.height * 0.15, view.frame.width * 0.30, view.frame.height * 0.30)
        startButton.addTarget(self, action: #selector(JSMainMenuViewController.startButtonPressed), forControlEvents: UIControlEvents.TouchUpInside)
        startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
        
        view.addSubview(titleLabel)
        view.addSubview(startButton)
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)

        
    }//addUI
    
    
    func startButtonPressed() {
        
        /*
        //TODO: make create a new game and continue game button/function
        
        if(isStarted == false)
        {
            isStarted = true
        }//if
        */
        performSegueWithIdentifier("toGame", sender: self)
        
        
    }
    
    
    
}//MainMenuViewController
