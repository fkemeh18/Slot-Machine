//
//  CircleView.swift
//  SlotMachineBINGO!
//
//  Created by Student on 11/12/18.
//  Copyright © 2018 ItBLikeThatSometimesStudios. All rights reserved.
//

import Foundation
import UIKit

class SlotCircle: Equatable{
    static func == (lhs: SlotCircle, rhs: SlotCircle) -> Bool {
        return (lhs.color == rhs.color) && (lhs.shade == rhs.shade)
    }
    
    var shade: Shades
    var color: Colors
    
    enum Shades {
        case outlined
        case striped
        case filled
        
        static var all = [Shades.outlined, .striped, .filled]
    }
    
    enum Colors {
        case red
        case blue
        case green
        case purple
        
        static var all = [Colors.red, .blue, .green, .purple]
    }
    
    init(shade: Shades, color: Colors) {
        self.shade = shade
        self.color = color
    }

}
