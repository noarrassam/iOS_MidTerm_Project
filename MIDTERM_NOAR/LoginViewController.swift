//
//  LoginViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-09.
//

import ShimmerSwift
import FBSDKLoginKit
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var forgetPass: UIButton!
    @IBOutlet weak var googleBtn1: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var facebookLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        // Shimmer View
        let shimmerView = ShimmeringView(frame: CGRect(x: 29, y: 680, width: 333, height: 52))
        view.addSubview(shimmerView)

        shimmerView.contentView = loginBtn
        
        // Start/Stop animation
        shimmerView.isShimmering = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onClickView))
        self.view.addGestureRecognizer(gesture)
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        //loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 218.0).isActive = true
        loginButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 218.0).isActive = true
    }
    
    @objc func onClickView() {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { self.loginImage.transform = CGAffineTransform(translationX: -25, y: 0)}) {(_) in
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.loginImage.alpha=0
                self.loginImage.transform = self.loginImage.transform.translatedBy(x: 0, y: -200)
            }, completion: nil)
        }
    }
    
    func setupButtons(){
        googleBtn1.layer.cornerRadius = 8
    }
    
    @IBAction func google(_ sender: UIButton) {
        sender.shake()
    }
    
    
    @IBAction func forgetPass(_ sender: UIButton) {
        sender.flash()
    }
}
