//
//  ViewController.swift
//  Extentions
//
//  Created by Akshay Kumar on 21/04/23.
//

import UIKit

class ViewController: UIViewController {

    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //MARK: UIButton Tapped Action
    @IBAction func showToastButtonTappedAction(_ sender: UIButton) {
        Toast.showToast(message: "Here message You want to show", controller: self)
    }
    

}

