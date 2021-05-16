//
//  SignUpViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-06.
//

import ShimmerSwift
import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var signUPBtn: UIButton!
    
    @IBOutlet weak var signUp: UIImageView!
    @IBOutlet weak var signUpConst: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var pass: UITextField!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let shimmerView = ShimmeringView(frame: CGRect(x: 29, y: 680, width: 333, height: 52))
        view.addSubview(shimmerView)

        shimmerView.contentView = signUPBtn
        
        // Start/Stop animation
        shimmerView.isShimmering = true

        // Do any additional setup after loading the view.
    }
}
