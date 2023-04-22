//
//  ViewController.swift
//  Extentions
//
//  Created by Akshay Kumar on 21/04/23.
//

import UIKit

class ViewController: UIViewController {

    //MARK: UIView
    @IBOutlet weak var dashShadowView: UIView!
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        dashShadowView.addDashedBorder(conerRadius: 20)
        
        dashShadowView.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }

    
    //MARK: UIButton Tapped Action
    @IBAction func showToastButtonTappedAction(_ sender: UIButton) {
        alert(message: "Hey I am here...")
        //Toast.showToast(message: "Here message You want to show", controller: self)
    }
    

}

