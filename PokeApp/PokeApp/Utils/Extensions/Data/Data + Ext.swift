//
//  Data + Ext.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation

extension Data {
    init<T>(array: [T]) throws {
        self = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
    }
}
