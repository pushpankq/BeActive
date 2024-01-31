//
//  Date+Extension.swift
//  beFit
//
//  Created by Pushpank Kumar on 01/02/24.
//

import Foundation

extension Date {
    static var startOfDay: Date {
         Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        let calendar = Calendar.current
        var component = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        component.weekday = 2
        return calendar.date(from: component)!
    }
}
