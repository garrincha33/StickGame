//
//  GameScene.swift
//  TheStickMan
//
//  Created by Richard Price on 02/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

    //MARK: - properties
    private let worldNode = SKNode()
    
    
    //MARK: - Life cycle
    override func didMove(to view: SKView) {
        
        setupNodes()
        
    }

}

//MARK:- configures
extension GameScene {
    
    func setupNodes() {
        addChild(worldNode)
        setupBG()
    }
    
    //MARK:- BG
    func setupBG() {
        for i in 0...2 {
            let bg = createBG()
            bg.zPosition = -1.0
            bg.name = "Bacground"
            bg.position = CGPoint(x: CGFloat(i)*bg.frame.width, y: 0.0)
            worldNode.addChild(bg)
        }
    }
    
    func createBG() -> SKSpriteNode {
        let bg = SKSpriteNode()
        bg.anchorPoint = .zero
        bg.name = "Background"
        
        let bg1 = SKSpriteNode(imageNamed: "bg1_1")
        bg1.anchorPoint = .zero
        bg1.position = .zero
        bg.addChild(bg1)
        
        let bg2 = SKSpriteNode(imageNamed: "bg1_2")
        bg2.anchorPoint = .zero
        bg2.position = CGPoint(x: bg1.frame.width, y: 0.0)
        bg.addChild(bg2)
        
        let bg3 = SKSpriteNode(imageNamed: "bg1_1")
        bg3.anchorPoint = .zero
        bg2.position = CGPoint(x: bg1.frame.width+2, y: 0.0)
        bg.addChild(bg3)
        
        bg.size = CGSize(width: bg1.frame.width*3, height: bg1.frame.height)
        
        return bg
    }
    
}
