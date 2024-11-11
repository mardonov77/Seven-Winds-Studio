//
//  String+Extension.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 06/11/24.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
   
    func toInt() -> Int? {
        return Int(self)
    }
}
