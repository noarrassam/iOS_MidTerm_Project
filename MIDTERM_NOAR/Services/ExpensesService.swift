//
//  ExpensesService.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-17.
//

import Foundation

class ExpensesService {
    static let shared = ExpensesService()
    
    var expenseCategories: [ExpenseCategory]
    
    init() {
        expenseCategories = [
            ExpenseCategory(
                name: "Test 1",
                expenses: [
//                    Expense(name: "Test expense 1", amount: 100, date: Date()),
//                    Expense(name: "Test expense 2", amount: 200, date: Date()),
//                    Expense(name: "Test expense 3", amount: 300, date: Date())
                ]
            ),
            ExpenseCategory(
                name: "Test 2",
                expenses: [
//                    Expense(name: "Test expense 4", amount: 400, date: Date()),
//                    Expense(name: "Test expense 5", amount: 500, date: Date())
                ]
            ),
            ExpenseCategory(
                name: "Test 3",
                expenses: [
//                    Expense(name: "Test expense 6", amount: 600, date: Date())
                ]
            )
        ]
    }
}
