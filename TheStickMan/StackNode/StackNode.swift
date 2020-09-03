//
//  StackNode.swift
//  TheStickMan
//
//  Created by Richard Price on 03/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import SpriteKit

class StackNode: SKShapeNode {
    
    override init() {
        super.init()
        
        name = ChildName.StackNode
        zPosition = 5.0
        strokeColor = .black
        fillColor = .black
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
