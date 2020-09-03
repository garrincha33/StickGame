//
//  Int+Ext.swift
//  TheStickMan
//
//  Created by Richard Price on 03/09/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import Foundation

extension Int {
        static func random(range: ClosedRange<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound))) + range.lowerBound
    }
}
