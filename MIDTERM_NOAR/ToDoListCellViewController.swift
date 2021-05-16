//
//  ToDoListCellViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-07.
//

import UIKit

class ToDoListCellViewController: UIViewController {

    public var item: CalenderViewController?
    public var item1: IndexPath?
    public var reminder: MyReminder?
    
    @IBOutlet var itemTitle: UILabel?
    @IBOutlet var itemDesc: UILabel?
    @IBOutlet var itemDate: UILabel?
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let source = reminder {
            itemTitle?.text = source.title
            itemDesc?.text = source.identifier
            itemDate?.text = ToDoListCellViewController.dateFormatter.string(from: source.date)
        }
    }
}
