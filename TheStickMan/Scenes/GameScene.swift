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
    private var leftStack = StackNode()
    private var leftRight = StackNode()
    private var stackMinWidth: CGFloat = 50.0
    private var stackMaxWidth: CGFloat = 300.00
    private let stackHeight: CGFloat = 500.00
    private var playableArea: CGRect {
        
        let ratio: CGFloat = appDl.isX ? 2.16 : 16/9
        let playableWidth = size.height / ratio
        let playableMargin = (size.width - playableWidth) / 2.0
        
        return CGRect(x: playableMargin, y: 0.0, width: playableWidth, height: size.height)
        
    }
    
    
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
        
        leftStack = createStack(false, xPos: 0.0)
        
        
    }
    
    //MARK:- BG
    func setupBG() {
        for i in 0...2 {
            let bg = createBG()
            bg.zPosition = -1.0
            bg.name = "Background"
            bg.position = CGPoint(x: CGFloat(i)*bg.frame.width, y: 0.0)
            worldNode.addChild(bg)
        }
    }
    
    func createBG() -> SKSpriteNode {
        let bg = SKSpriteNode()
        bg.anchorPoint = .zero
        bg.name = ChildName.Background
        
        let bg1 = SKSpriteNode(imageNamed: "bg1_1")
        bg1.anchorPoint = .zero
        bg1.position = .zero
        bg.addChild(bg1)
        
        let bg2 = SKSpriteNode(imageNamed: "bg1_2")
        bg2.anchorPoint = .zero
        bg2.position = CGPoint(x: bg1.frame.width, y: 0.0)
        bg.addChild(bg2)
        
        let bg3 = SKSpriteNode(imageNamed: "bg1_3")
        bg3.anchorPoint = .zero
        bg2.position = CGPoint(x: bg1.frame.width+2, y: 0.0)
        bg.addChild(bg3)
        
        bg.size = CGSize(width: bg1.frame.width*3, height: bg1.frame.height)
        
        return bg
    }
    
}

//MARK:- Stack

extension GameScene {

    func createStack(_ anim: Bool, xPos: CGFloat) -> StackNode {
        
        let min = Int(stackMinWidth/10)
        let max = Int(stackMaxWidth/10)
        let width = CGFloat(Int.random(range: min...max)*10)
        let size = CGSize(width: width, height: stackHeight)
        let stack = StackNode(rectOf: size)
        
        if anim {
            stack.position = CGPoint(x: screenWidth, y: stackHeight/2)
        } else {
            stack.position = CGPoint(x: xPos + width/2, y: stackHeight/2)
        }
        
        
        //set postion of stacknode
        worldNode.addChild(stack)
        return stack
        
    }
    

}
