//
//  UIVIew+Extension.swift
//  Extentions
//
//  Created by Akshay Kumar on 29/07/23.
//

import Foundation
import UIKit

extension UIView {
    
    func fixInView(_ container: UIView!) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    
    func asImage(size: CGRect) -> UIImage {
           if #available(iOS 10.0, *) {
               let renderer = UIGraphicsImageRenderer(bounds: size)
               return renderer.image { rendererContext in
                   layer.render(in: rendererContext.cgContext)
               }
           } else {
               UIGraphicsBeginImageContext(self.bounds.size)
               self.layer.render(in: UIGraphicsGetCurrentContext()!)
               let image = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               return UIImage(cgImage: image!.cgImage!)
           }
       }
}
