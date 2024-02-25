//
//  String+Extension.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 25/02/2024.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self) || isEmpty == true
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    var isValidPassword: Bool {
        let passwordPattern =
            // At least 6 characters
            #"(?=.{6,})"# //+
//
//            // At least one capital letter
//            #"(?=.*[A-Z])"# +
//
//            // At least one lowercase letter
//            #"(?=.*[a-z])"# +
//
//            // At least one digit
//            #"(?=.*\d)"#
            
        let result = self.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return result != nil
    }
    
    var is8CharLong: Bool {
        let passwordPattern =
            // At least 8 characters
            #"(?=.{8,})"#
           
        let result = self.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return result != nil
    }
    
    var hasUpperCase: Bool {
        let passwordPattern =
            // At least one capital letter
            #"(?=.*[A-Z])"#
           
        let result = self.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return result != nil
    }
    
    var hasLowerCase: Bool {
        let passwordPattern =
            // At least one capital letter
            #"(?=.*[a-z])"#
           
        let result = self.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return result != nil
    }
    
    var hasDigit: Bool {
        let passwordPattern =
            // At least one digit
            #"(?=.*\d)"#
           
        let result = self.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return result != nil
    }
    
}

