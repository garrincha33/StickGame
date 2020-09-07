//
//  CGFloat+Ext.swift
//  TheStickMan
//
//  Created by Richard Price on 03/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import CoreGraphics

public let pii = CGFloat.pi

extension CGFloat {
    static func random() -> CGFloat {
        //returns random value of 0 or 1
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    //returns random value of min or max
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
    
     func degreesToRadiens() -> CGFloat {
        return self * pii / 180
    }
    
     func radiensToDegrees() -> CGFloat {
           return self * 180 / pii
       }
    
}
