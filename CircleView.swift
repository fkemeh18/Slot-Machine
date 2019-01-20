//
//  CircleView.swift
//  SlotMachineBINGO!
//
//  Created by Student on 11/12/18.
//  Copyright © 2018 ItBLikeThatSometimesStudios. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class CircleView: UIView{
    
   var shade: SlotCircle.Shades = SlotCircle.Shades.striped {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    var color: SlotCircle.Colors = SlotCircle.Colors.purple {
        didSet {
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    
    
    /*************************************************/
    /*              Circle boi                       */
    /*************************************************/
    
    
    
    private struct CircleMaker{
        static let verticalOffsetPercentage:    CGFloat = 0.20
        static let curveHeightPercentage:       CGFloat = 0.10
        static let widthPercentage:             CGFloat = 0.20
        static let verticalCurvePercentage:     CGFloat = 0.10
    }
    
    private var upperCurveStart: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - self.bounds.width * CircleMaker.widthPercentage/2.0,
                       y: self.bounds.size.height * (CircleMaker.verticalOffsetPercentage + CircleMaker.verticalCurvePercentage))
    }
    
    private var upperCurveEnd: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + self.bounds.width * CircleMaker.widthPercentage/2.0,
                       y: self.bounds.size.height * (CircleMaker.verticalOffsetPercentage + CircleMaker.verticalCurvePercentage))
    }
    
    private var lowerCurveStart: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 + self.bounds.width * CircleMaker.widthPercentage/2.0,
                       y: self.bounds.size.height - (self.bounds.height * (CircleMaker.verticalOffsetPercentage + CircleMaker.verticalCurvePercentage)))
    }
    
    private var lowerCurveEnd: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0 - self.bounds.width * CircleMaker.widthPercentage/2.0,
                       y: self.bounds.size.height - (self.bounds.height * (CircleMaker.verticalOffsetPercentage + CircleMaker.verticalCurvePercentage)))
    }
    
    private var upperCurveCenter: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0,
                       y: upperCurveStart.y)
    }
    
    private var lowerCurveCenter: CGPoint {
        return CGPoint(x: self.bounds.size.width/2.0,
                       y: lowerCurveStart.y)
    }
    
    private var curveRadius: CGFloat {
        return (upperCurveEnd.x - upperCurveStart.x)/2.0
    }
    
    func drawCircle() -> UIBezierPath {
        let circle = UIBezierPath()
        
        circle.move(to: lowerCurveEnd)
        circle.addLine(to: upperCurveStart)
        circle.addArc(withCenter: upperCurveCenter,
                    radius: curveRadius,
                    startAngle: CGFloat.pi,
                    endAngle: 0.0,
                    clockwise: true)
        circle.addLine(to: lowerCurveStart)
        circle.addArc(withCenter: lowerCurveCenter,
                    radius: curveRadius,
                    startAngle: 0.0,
                    endAngle: CGFloat.pi,
                    clockwise: true)
        circle.close()
        return circle
    }
    
    
    
    /*************************************************/
    /*              Show boi                         */
    /*************************************************/
    
    
    
    private func showPath(_ path: UIBezierPath) {
        var path = replicatePath(path)
        colorForPath.setStroke()
        path = shadePath(path)
        path.lineWidth = 2.0
        path.stroke()
        path.fill()
    }
    
    
    private func replicatePath(_ path: UIBezierPath) -> UIBezierPath {
        let replicatedPath = UIBezierPath()
        replicatedPath.append(path)
        return replicatedPath
    }
    
    
    private var colorForPath: UIColor {
        switch color {
            case .red:
                return UIColor.red
            case .blue:
                return UIColor.blue
            case .green:
                return UIColor.green
            case .purple:
                return UIColor.purple
        }
    }
    
    private func shadePath(_ path: UIBezierPath) -> UIBezierPath {
        let shadedPath = UIBezierPath()
        shadedPath.append(path)
        
        switch shade {
        case .filled:
            colorForPath.setFill()
        case .striped:
            UIColor.clear.setFill()
            shadedPath.addClip()
            var start = CGPoint(x: 0.0, y: 0.0)
            var end = CGPoint(x: self.bounds.size.width, y: 0.0)
            let dy: CGFloat = self.bounds.height / 10.0
            while start.y <= self.bounds.height {
                shadedPath.move(to: start)
                shadedPath.addLine(to: end)
                start.y += dy
                end.y += dy
            }
        case .outlined:
            UIColor.clear.setFill()
        }
        
        return shadedPath
    }
    
    /***********************************************************/
    /*                        draw boi                         */
    /***********************************************************/
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds,
                                       cornerRadius: 16)
        roundedRect.addClip()
        
        UIColor.white.setFill()
        roundedRect.fill()
        roundedRect.stroke()
        
        let path = UIBezierPath()
        path.append(drawCircle())
        
        showPath(path)
    }
    
}

