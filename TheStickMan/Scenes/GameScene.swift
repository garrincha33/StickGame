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
    private var rightStack = StackNode()
    private let hero = HeroNode()
    private var stick: SKSpriteNode!
    private var leftStacks: [StackNode] = []
    private var stackMinWidth: CGFloat = 50.0
    private var stackMaxWidth: CGFloat = 300.00
    private let stackHeight: CGFloat = 500.00
    private let gapMinWidth = 60
    private var nextValueX: CGFloat = 0.0
    private let heroSpeed: CGFloat = 760.0
    private var stickHeight: CGFloat = 0.0
    private var stickNumber: CGFloat = 0
    private var isBegin = false
    private var isEnd = false
    
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
    
    //sticknode is created once we touch the screen
    //with touches began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("touched")
        if !isBegin && !isEnd {
            isBegin = true
            stick = createStick()
        
            let resizeAction = SKAction.resize(toHeight: screenHeight-stackHeight, duration: 1.5)
            stick.run(resizeAction, withKey: ActionKey.StickResize)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if isBegin && !isEnd {
            isEnd = true
            
            let rotationAction = SKAction.rotate(toAngle: CGFloat(-90).degreesToRadiens(), duration: 0.7, shortestUnitArc: true)
            stick.removeAction(forKey: ActionKey.StickResize)
            stickHeight = stick.frame.height
            stick.run(.sequence([.wait(forDuration: 0.2), rotationAction])) { [unowned self] in
                self.heroGo(self.checkPass())
   
            }
        }
    }
}

//MARK:- configures
extension GameScene {
    func setupNodes() {
        addChild(worldNode)
        setupBG()
        leftStack = createStack(false, xPos: 0.0)
        createHero()
        let maxGap = Int(playableArea.width - stackMaxWidth - leftStack.frame.width)
        let gap = CGFloat(Int.random(range: gapMinWidth...maxGap))
        rightStack = createStack(false, xPos: gap + nextValueX)
        
        setupPhysics()
    }
    
    func setupPhysics() {
        physicsWorld.gravity.dy = -100.00
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
        bg3.position = CGPoint(x: bg1.frame.width+2, y: 0.0)
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
            let moveAction = SKAction.moveTo(x: xPos, duration: 0.3)
            stack.run(moveAction)  { [unowned self] in
                self.isBegin = false
                self.isEnd = false
            }
        } else {
            stack.position = CGPoint(x: xPos + width/2, y: stackHeight/2)
        }
        //set postion of stacknode, adding to the worldNode which is the background
        nextValueX = xPos + width
        worldNode.addChild(stack)
        return stack
    }
    
    func moveAndCreateStack() {
        
        let value: CGFloat = appDl.iPad ? 0.0 : 16.0
        let xRightStack = rightStack.frame.width/2 + value
        let moveAction = SKAction.moveTo(x: xRightStack, duration: 0.5)
        rightStack.run(moveAction) { [unowned self] in
            if self.stickNumber == 2 {
                for child in self.worldNode.children {
                    if child.name == "Stick1" {
                        child.removeFromParent()
                    }
                }
            }
        }
        
        worldNode.enumerateChildNodes(withName: ChildName.Background) { (node, _) in
            guard let bg = node as? SKSpriteNode else {return}
            bg.run(.moveBy(x: -100.00, y: 0.0, duration: 0.6))
            if bg.position.x + bg.frame.width < -self.frame.width {
                bg.position.x += bg.position.x + bg.frame.width*3
            }
        }
        
        let xHero = value + (rightStack.frame.width - hero.frame.width/2)
        let moveHAction = SKAction.moveTo(x: xHero, duration: 0.5)
        hero.run(moveHAction)
        
        let xStick = -stickHeight + value
        let moveSAction = SKAction.moveTo(x: xStick, duration: 0.5)
        stick.run(moveSAction) { [unowned self] in
            if self.stickNumber == 2 {
                self.stickNumber = 1
                self.stick.name = "Stick\(self.stickNumber)"
            }
        }
        
        if self.leftStacks.count != 0 {
            self.leftStacks[0].run(.sequence([.wait(forDuration: 0.3), .removeFromParent()]))
            
        }
        
        let xLeftStack = -leftStack.frame.width/2
        let moveLAction = SKAction.moveTo(x: xLeftStack, duration: 0.5)
        leftStack.run(moveLAction) {
            self.leftStacks.removeAll()
            self.leftStacks.append(self.leftStack.copy() as! StackNode)
            self.leftStacks[0].position = self.leftStack.position
            self.worldNode.addChild(self.leftStacks[0])
            self.leftStack.removeFromParent()
            self.leftStack = self.rightStack
            
            let rightSW = self.rightStack.frame.width
            let maxGap = Int(self.playableArea.width - rightSW - self.stackMaxWidth)
            let gap = CGFloat(Int.random(range: self.gapMinWidth...maxGap))
            let xPos = value + rightSW + gap
            self.rightStack = self.createStack(true, xPos: xPos)
            
           }
        }
    }


//MARK:- HeroStack
extension GameScene {
    func createHero() {
        //set hero ontop of left stack and add to worldNode
        let x =  leftStack.position.x - 15.0
        let y = stackHeight + hero.frame.height / 2
        hero.position = CGPoint(x: x, y: y)
        worldNode.addChild(hero)
    }
    
    func heroGo(_ checkPass: Bool) {
        guard checkPass else {
            let distance = stick.position.x + stickHeight
            let gap = nextValueX - rightStack.frame.width / 2 - abs(hero.position.x)
            let duration = TimeInterval(gap / heroSpeed)
            let moveAction = SKAction.moveTo(x: distance, duration: duration)
            hero.run(moveAction)  { [unowned self] in
    
                self.stick.run(.rotate(toAngle: CGFloat(-180).degreesToRadiens(), duration: 0.3))
                self.hero.physicsBody?.affectedByGravity = true
            }
            return
        }
        
        let distance = nextValueX - hero.frame.width / 2
        let gap = nextValueX - rightStack.frame.width / 2 - abs(hero.position.x)
        let duration = TimeInterval(gap / heroSpeed)
        
        let moveAction = SKAction.moveTo(x: distance, duration: duration)
        hero.run(moveAction) { [unowned self] in
            self.moveAndCreateStack()
        }
    }
    
    //Has hero passed?
    func checkPass() -> Bool {
        guard stickHeight + stick.position.x < nextValueX else {return false}
        guard leftStack.frame.intersects(stick.frame) && rightStack.frame.intersects(stick.frame) else {return false}
        return true
    }
}

//MARK:- StickNode
extension GameScene {
    func createStick() -> SKSpriteNode {
        let stickSize = CGSize(width: 12, height: 1.0)
        let stick = SKSpriteNode(texture: nil, color: .black, size: stickSize)
        stickNumber += 1
        stick.zPosition = 5.0
        stick.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        stick.name = "Stick\(stickNumber)"
        
        let x = leftStack.frame.maxX - 6.0
        let y = hero.position.y - hero.frame.height / 2
        stick.position = CGPoint(x: x, y: y)
        worldNode.addChild(stick)
        
        return stick
        
    }
    
}

