//
//  ExpenseCell.swift
//  MIDTERM_NOAR
//
//  Created by Jan Kaltoun on 17.03.2021.
//

import UIKit

class ExpenseCell: UITableViewCell  {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension ExpenseCell {
    func update(with expense: Expense) {
        // Description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.y"
        
        let formattedDate = dateFormatter.string(from: expense.date)
        
        descriptionLabel.text = "\(expense.name) | \(formattedDate)"
        
        // Amount
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_CA")
        
        let formattedAmount = currencyFormatter.string(from: NSNumber(value: expense.amount))
        
        amountLabel.text = formattedAmount
    }
}
