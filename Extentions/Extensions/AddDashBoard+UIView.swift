//
//  AddDashBoard+UIView.swift
//  Extentions
//
//  Created by Akshay Kumar on 22/04/23.
//

import Foundation
import UIKit

extension UIView {
    func addDashedBorder(conerRadius : CGFloat) {
        let color = UIColor.gray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [8,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: conerRadius).cgPath
        self.layer.addSublayer(shapeLayer)
    }
}
