//
//  Extension.swift
//  DynamicForm
//
//  Created by Macintosh on 06/04/21.
//

import UIKit

extension Double {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: Double(self))) ?? "0"
    }
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ID")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "Rp "
        return formatter.string(from: NSNumber(value: self)) ?? "Rp 0"
    }
}

extension String {
    // MARK: Convert String date from backend (UTC) to Local
    func toDate(dateFormat format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "ID")
        return formatter.date(from: self)
    }
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "ID")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "Rp "
        return formatter.string(from: NSNumber(value: Double(self) ?? 0)) ?? "Rp 0"
    }
    
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    func regex(with pattern: String) -> Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}

extension UIViewController {
    func getAllTextFields(fromView view: UIView)-> [UITextField] {
        return view.subviews.compactMap { (view) -> [UITextField]? in
            if view is UITextField {
                return [(view as! UITextField)]
            } else {
                return getAllTextFields(fromView: view)
            }
        }.flatMap({$0})
    }
}
