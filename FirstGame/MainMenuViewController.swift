//
//  MainMenuViewController.swift
//  FirstGame
//
//  Created by Esa Serog on 10/19/15.
//  Copyright © 2015 esaSerog. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController
{
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "Add an Activity"
        view.backgroundColor = UIColor.greenColor() //for testing purposes
        
        
        addUI()
        
    }//viewWillAppear
    
    
    
    //create variables and constants
    let startButton = UIButton()
    let titleLabel = UILabel()
    //var isStarted: Bool = false
    
    func addUI()
    {
        
        //start button
        startButton.frame = CGRectMake(view.frame.width/2.0, view.frame.height/2.0, view.frame.size.width * 0.50, view.frame.size.width * 0.1)
        startButton.titleLabel?.textAlignment = NSTextAlignment.Center
        startButton.setTitle("Start!", forState: UIControlState.Normal)
        startButton.addTarget(self, action: "startButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(startButton)
        
        
    }//addUI
    
    
    
    
    func startButtonPressed()
    {
        /*
        if(isStarted == false)
        {
            isStarted = true
        }//if
        */
        performSegueWithIdentifier("toGame", sender: self)
        
        
    }
    
    
}//MainMenuViewController
