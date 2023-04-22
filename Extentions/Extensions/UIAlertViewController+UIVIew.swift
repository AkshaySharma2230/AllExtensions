//
//  UIAlertViewController+UIVIew.swift
//  Extentions
//
//  Created by Akshay Kumar on 22/04/23.
//

import Foundation
import UIKit

//MARK: Simple+Alert
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
 
