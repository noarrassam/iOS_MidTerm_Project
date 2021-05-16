//
//  AddViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-07.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet var titleField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet weak var creatRm: UIButton!
    @IBOutlet weak var bodyField: UITextView!
    
    public var completion: ((String, String, Date)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backBarBtnItem = UIBarButtonItem()
//            backBarBtnItem.title = "List"
//            navigationItem.backBarButtonItem = backBarBtnItem
        
        titleField.delegate = self
        bodyField.delegate = self

        didTapSaveButton()
    }
    
    @IBAction func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text , !bodyText.isEmpty {
            let targetDate = datePicker.date
            
            completion?(titleText, bodyText, targetDate)
            print("Hello")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
