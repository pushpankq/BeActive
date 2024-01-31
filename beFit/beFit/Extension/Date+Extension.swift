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
}
