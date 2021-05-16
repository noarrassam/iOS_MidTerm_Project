//
//  ViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-06.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var checkMarkBtn: UIImageView!
    
    @IBOutlet weak var organizeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMarkBtn.layer.cornerRadius = 15.0
        organizeBtn.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        checkMarkBtn.center.x = self.view.frame.width + 50
        UIView.animate(withDuration: 1.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {self.checkMarkBtn.center.x = self.view.frame.width / 2}, completion: nil)
        
        organizeBtn.center.x = self.view.frame.width + 50
        UIView.animate(withDuration: 1.0, delay: 00, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .allowAnimatedContent, animations: {self.organizeBtn.center.x = self.view.frame.width / 2}, completion: nil)
    }
    
    @objc private func didTapButton() {
        let rootVC = UIViewController()
        rootVC.title = "Verification Code"
        let navVC = UINavigationController(rootViewController: rootVC)
        
        present(navVC, animated: true)
    }
}
