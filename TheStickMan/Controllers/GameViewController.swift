//
//  GameViewController.swift
//  TheStickMan
//
//  Created by Richard Price on 02/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let scene = GameScene(size: CGSize(width: screenWidth, height: screenHeight))
        scene.scaleMode = .aspectFit
        
        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)


        }
    



    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    
}
