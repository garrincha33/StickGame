//
//  HeroNode.swift
//  TheStickMan
//
//  Created by Richard Price on 03/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import SpriteKit

class HeroNode: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "hero0_1")
        super.init(texture: texture, color: .clear, size: texture.size())
        zPosition = 5.0
        setScale(0.35)
        
        setupPhysics()
    }
    
    fileprivate func setupPhysics() {
        let size = frame.insetBy(dx: 15.0, dy: 0.0).size
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
