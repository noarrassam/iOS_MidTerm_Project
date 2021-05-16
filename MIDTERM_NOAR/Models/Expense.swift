//
//  Expense.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-17.
//

import Foundation

class Expense {
    let name: String
    let amount: Double
    let date: Date
    
    init(name: String, amount: Double, date: Date) {
        self.name = name
        self.amount = amount
        self.date = date
    }
}
