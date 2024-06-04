//
//  Array + Ext.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation

extension Array {
    init(data: Data) throws {
        self = try JSONSerialization.jsonObject(with: data, options: []) as! Array<Element>
    }
}
