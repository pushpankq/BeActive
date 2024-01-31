//
//  Double+Extension.swift
//  beFit
//
//  Created by Pushpank Kumar on 01/02/24.
//

import Foundation

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
