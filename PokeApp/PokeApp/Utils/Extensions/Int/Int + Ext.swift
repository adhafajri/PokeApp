//
//  Int + Ext.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation

extension Int {
    func isPrime() -> Bool {
        guard self > 1 else { return false }
        guard self > 3 else { return true }
        
        for i in 2...Int(sqrt(Double(self))) {
            if self % i == 0 {
                return false
            }
        }
        
        return true
    }
}
