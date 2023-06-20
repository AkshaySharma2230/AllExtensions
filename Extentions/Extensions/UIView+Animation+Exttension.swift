//
//  UIView+Animation+Exttension.swift
//  Extentions
//
//  Created by Akshay Kumar on 20/06/23.
//

import Foundation
import UIKit


extension UIViewController {
    func pAnimation(animationDirection:AnimationDirection, animateTO: [UIView]) {
         
         guard animationDirection != .none else { return }
        
        let views = animateTO
        var index = 0
        let selfHeight: CGFloat = self.view.bounds.size.height
        for i in views {
            let view: UIView = i as UIView
            
            switch animationDirection {
            case .up:
                view.transform = CGAffineTransform(translationX: 0, y: -selfHeight)
                break
            case .down:
                view.transform = CGAffineTransform(translationX: 0, y: selfHeight)
                break
            case .left:
                view.transform = CGAffineTransform(translationX: selfHeight, y: 0)
                break
            case .right:
                view.transform = CGAffineTransform(translationX: -selfHeight, y: 0)
                break
            default:
                view.transform = CGAffineTransform(translationX: selfHeight, y: 0)
                break
            }
            view.isHidden = false
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                view.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
}
