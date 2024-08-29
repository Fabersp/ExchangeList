//
//  Format.swift
//  MyCoins
//
//  Created by Fabricio Padua on 8/28/24.
//

import Foundation

class format {
    
    func formatNumberSort(_ number: Double) -> String {
        let absNumber = abs(number)
        let sign = number < 0 ? "-" : ""
        
        switch absNumber {
        case 1_000_000_000_000...:
            let formatted = absNumber / 1_000_000_000_000
            return "\(sign)\(String(format: "%.2f", formatted)) T"
        case 1_000_000_000...:
            let formatted = absNumber / 1_000_000_000
            return "\(sign)\(String(format: "%.2f", formatted)) B"
        case 1_000_000...:
            let formatted = absNumber / 1_000_000
            return "\(sign)\(String(format: "%.2f", formatted)) M"
        default:
            return "\(sign)\(String(format: "%.2f", absNumber))"
        }
    }
    
    func formatNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale.current
        return numberFormatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
}
