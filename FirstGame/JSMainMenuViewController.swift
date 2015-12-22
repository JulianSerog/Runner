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
    let startButton = UIButton(type: UIButtonType.System)
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    //var isStarted: Bool = false
    
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        addUI()
    }//viewWillAppear
    
    
    func addUI()
    {
        
        // 1) bg image
        backgroundImage.image = UIImage(named: "space.jpg")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImage.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        backgroundImage.alpha = 1.0
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
        
        
        // 2)Game Title
        titleLabel.text = "Star Racer"
        titleLabel.frame = CGRectMake(0, 0, view.frame.width, view.frame.height * 0.20)
        titleLabel.textAlignment = NSTextAlignment.Center
        //titleLabel.backgroundColor = UIColor.clearColor()
        view.addSubview(titleLabel)

        // 3)start button
        startButton.frame = CGRectMake(view.frame.width/2.0 - (view.frame.width * 0.10)/2, view.frame.height/2 - (view.frame.height * 0.10)/2, view.frame.width * 0.10, view.frame.height * 0.10)
        startButton.backgroundColor = UIColor.whiteColor()
        startButton.titleLabel?.textAlignment = NSTextAlignment.Center
        startButton.titleLabel?.textAlignment = NSTextAlignment.Center
        startButton.setTitle("Start!", forState: UIControlState.Normal)
        startButton.tintColor = UIColor.clearColor()
        startButton.addTarget(self, action: "startButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(startButton)
        startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        
        
    }//addUI
    
    
    
    
    func startButtonPressed()
    {
        
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
