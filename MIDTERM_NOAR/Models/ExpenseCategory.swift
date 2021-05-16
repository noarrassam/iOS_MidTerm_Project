//
//  ExpenseCategory.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-17.
//

import Foundation

class ExpenseCategory {
    let name: String
    var expenses: [Expense]
    
    var totalSpent: Double {
        expenses.reduce(0) { result, expense in
            result + expense.amount
        }
    }
    
    init(name: String, expenses: [Expense]) {
        self.name = name
        self.expenses = expenses
    }
}
