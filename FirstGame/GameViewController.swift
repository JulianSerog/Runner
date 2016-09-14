//
//  GameViewController.swift
//  FirstGame
//
//  Created by Esa Serog on 6/2/15.
//  Copyright (c) 2015 esaSerog. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    
    var scene: GameScene!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure the view
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = true
        
        //create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        //present the scene
        skView.presentScene(scene)
        
    }//viewDidLoad

    
    
    
    
    override var shouldAutorotate : Bool
    {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return UIInterfaceOrientationMask.allButUpsideDown
        }//if
        else
        {
            return UIInterfaceOrientationMask.all
        }//else
    }//supportedInterfaceOrientations

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }//didRecieveMemoryWarning

    override var prefersStatusBarHidden : Bool
    {
        return false //changed to false for now
    }//prefersStatusBarHidden
}//GameViewController
