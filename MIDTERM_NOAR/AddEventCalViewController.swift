//
//  AddEventCalViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-10.
//

import UIKit
protocol AddEventDelegate: AnyObject{
    func onAddEvent(event: Event)
}

class Event:NSObject{
    var name:String?
    var detail: Date?
    var note:String?
}

class AddEventCalViewController: UIViewController {

    weak var delegate : AddEventDelegate?
    
    @IBOutlet weak var eventNameTxt: UITextField!
    @IBOutlet weak var timeDatepicker: UIDatePicker!
    @IBOutlet weak var notesTxt: UITextView!
    @IBOutlet weak var createEventBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func eventName(_ sender: Any) {
        
        if eventNameTxt.text != "" {
            if notesTxt.text != "" {
                if timeDatepicker.date != Date.init() {
                let event = Event()
                event.name = eventNameTxt.text
                event.detail = timeDatepicker.date
                event.note = notesTxt.text
                delegate?.onAddEvent(event: event)
                navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
