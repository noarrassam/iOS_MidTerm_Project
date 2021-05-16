//
//  Date+Extras.swift
//  MIDTERM_NOAR
//
//  Created by Noor Rassam on 2021-03-17.
//

import Foundation

extension Date {
    var startOfMonth: Date {
        Calendar.current.date(
            byAdding: DateComponents(day: 10),
            to: Calendar.current.date(
                from: Calendar.current.dateComponents(
                    [.year, .month],
                    from: Calendar.current.startOfDay(for: self)
                )
            )!
        )!
    }
    
    var startOfNextMonth: Date {
        Calendar.current.date(
            byAdding: DateComponents(month: 1),
            to: startOfMonth
        )!
    }
    
    var startOfPreviousMonth: Date {
        Calendar.current.date(
            byAdding: DateComponents(month: -1),
            to: startOfMonth
        )!
    }
}
