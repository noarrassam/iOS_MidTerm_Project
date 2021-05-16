//
//  VerificationViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-09.
//

import UIKit

class VerificationViewController: UIViewController {

    @IBOutlet weak var smsText: UIImageView!
    
    @IBOutlet weak var smsText1: NSLayoutConstraint!
    
    @IBOutlet weak var codeNotRecieved: UIButton!
    
    @IBOutlet var notRecieved: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smsText.center.x = self.view.frame.width + 50
        codeNotRecieved.center.x = self.view.frame.width + 50
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        smsText1.constant -= view.bounds.width
      
        UIView.animate(withDuration: 0.5) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        smsText1.constant = -200
            
        UIView.animate(withDuration: 1,
                       delay: 0.3,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
          }, completion: nil)
        
        notRecieved.constant = -100
        UIView.animate(withDuration: 1,
                       delay: 0.3,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
          }, completion: nil)
        
        animate()
        
        UIView.animate(withDuration: 1,
                           delay: 1.2,
                           options: .curveEaseInOut,
                           animations: { [weak self] in
                            self?.smsText.backgroundColor = .systemYellow
              }, completion: nil)
        
        UIView.animate(withDuration: 5,
                           delay: 1.2,
                           options: [.curveEaseInOut, .repeat],
                           animations: { [weak self] in
                            self?.codeNotRecieved.backgroundColor = .orange
              }, completion: nil)

    }
    
    private func animate() {
        let options: UIView.AnimationOptions = [.curveEaseInOut,
                                                .repeat,
                                                .autoreverse]
        
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: { [weak self] in
          self?.view.layoutIfNeeded()
            self?.smsText.frame.size.height *= 1.28
            self?.smsText.frame.size.width *= 1.28
        }, completion: nil)
    }
}
