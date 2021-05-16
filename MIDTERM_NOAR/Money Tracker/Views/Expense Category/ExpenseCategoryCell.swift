//
//  ExpenseCategoryCell.swift
//  MIDTERM_NOAR
//
//  Created by Jan Kaltoun on 17.03.2021.
//

import UIKit

class ExpenseCategoryCell: UICollectionViewCell {
    @IBOutlet weak var totalSpentLabel: UILabel!
}

extension ExpenseCategoryCell {
    func update(with category: ExpenseCategory) {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "en_CA")
        
        let formattedAmount = currencyFormatter.string(from: NSNumber(value: category.totalSpent))
        
        totalSpentLabel.text = formattedAmount
    }
}
