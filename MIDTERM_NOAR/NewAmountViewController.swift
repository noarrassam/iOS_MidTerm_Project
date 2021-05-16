//
//  NewAmountViewController.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-14.
//

import UIKit

protocol NewAmountViewControllerDelegate: AnyObject{
    func didAddExpense()
}

class NewAmountViewController: UIViewController {
    weak var delegate : NewAmountViewControllerDelegate?
    
    @IBOutlet weak var amountName: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var timeDate: UIDatePicker!
    
    lazy var categoryPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        return picker
    }()
    
    lazy var categoryToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()

        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.pickerDoneTapped))

        toolbar.setItems([spaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
    let expensesService = ExpensesService.shared
    
    var categoryNames: [String] {
        [""] + expensesService.expenseCategories.map { $0.name }
    }
    
    @IBAction func enterAmount(_ sender: Any) {
        guard
            let name = amountName.text,
            let amountText = amount.text,
            let amount = Double(amountText),
            let categoryName = category.text, !categoryName.isEmpty,
            let category = expensesService.expenseCategories.first(where: { $0.name == categoryName })
        else {
            return
        }
        
        let expense = Expense(
            name: name,
            amount: amount,
            date: timeDate.date
        )
        
        category.expenses.append(expense)
        
        delegate?.didAddExpense()
        
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension NewAmountViewController {
    func setupUI() {
        category.inputView = categoryPicker
        category.inputAccessoryView = categoryToolbar
    }
    
    @objc func pickerDoneTapped() {
        category.resignFirstResponder()
    }
}

extension NewAmountViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        expensesService.expenseCategories.count + 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryNames[row]
    }
}

extension NewAmountViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category.text = categoryNames[row]
    }
}
