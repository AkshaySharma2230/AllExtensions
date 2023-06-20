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
    @IBOutlet weak var stringLabel: UILabel!
    

    //MARK: Define Variable
    let text = "The Department of Health recommends adults are moderately active for 150 minutes or vigorously active for 75 minutes each week.In an average week, how close are you to achieving this ?"
    
        
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        dashShadowView.addDashedBorder(conerRadius: 20)
        dashShadowView.layer.cornerRadius = 20
        lblTextColorChange()
        startAnimation()
        // Do any additional setup after loading the view.
    }

    
    //MARK: SetColorText
    func lblTextColorChange() {
        let string = NSMutableAttributedString(string: text)
        
        string.setColorForText("TheDepartmentofHealthrecommendsadultsare", with: #colorLiteral(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1))
        string.setColorForText("active for 150 minutes or", with: #colorLiteral(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1))
        string.setColorForText("active for 75 minutes each week. In an average week, how close are you to achieving this ?", with: #colorLiteral(red: 0.0/255, green: 0.0/255, blue: 0.0/255, alpha: 1))
        string.setColorForText("moderately", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        string.setColorForText("vigorously", with: #colorLiteral(red: 0.9843137255, green: 0.4941176471, blue: 0.1294117647, alpha: 1))
        stringLabel.attributedText = string
        
    }
    
    
    
    //MARK: UIView+label+TextFied etc animation
    func startAnimation() {
        pAnimation(animationDirection: .left, animateTO: [stringLabel])
    }
    
    
    
    //MARK: UIButton Tapped Action
    @IBAction func showToastButtonTappedAction(_ sender: UIButton) {
        alert(message: "Hey I am here...")
        //Toast.showToast(message: "Here message You want to show", controller: self)
    }
    

}

