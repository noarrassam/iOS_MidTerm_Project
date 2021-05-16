//
//  NotificationViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-09.
//

import ShimmerSwift
import TransitionButton
import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var contBtn: UIButton!
    @IBOutlet weak var phonImage: UIImageView!
    @IBOutlet weak var phonImageConst: NSLayoutConstraint!
    @IBOutlet weak var lorem: UIImageView!
    @IBOutlet weak var loremDesc: UIButton!
    let button = TransitionButton(frame: CGRect(x: 0, y: 0, width: 150, height: 30))
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupButtons()
        phonImage.center.x = self.view.frame.width + 50
         
        button.center = view.center
        button.backgroundColor = .systemPink
        button.setTitle("Click Me", for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        button.spinnerColor = .white
        
        view.addSubview(button)
    }
    
    
    
    @objc func didTapButton() {
        button.startAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        phonImageConst.constant -= view.bounds.width
      
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        phonImageConst.constant = 0
            
        UIView.animate(withDuration: 1,
                       delay: 0.3,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
          }, completion: nil)
        
        lorem.fadeIn()
        lorem.fadeIn(0.5)
        
        lorem.fadeOut(0.3)    // uses default duration of 0.3
        lorem.fadeOut(1.0) // uses custom duration (1.0 in this example)

        // fadeTo() - used if you want a custom alpha value
        lorem.fadeTo(-1.0)  // uses default duration of 0.3
        lorem.fadeTo(0.5, duration: 1.0)
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.pulsate()
    }
    
    func setupButtons() {
        loremDesc.layer.cornerRadius = 8
    }
}

extension UIView {
  func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
    DispatchQueue.main.async {
      UIView.animate(withDuration: duration) {
        self.alpha = alpha
      }
    }
  }

  func fadeIn(_ duration: TimeInterval = 0.3) {
    fadeTo(1.0, duration: duration)
  }

  func fadeOut(_ duration: TimeInterval = 0.3) {
    fadeTo(0.0, duration: duration)
  }
}
