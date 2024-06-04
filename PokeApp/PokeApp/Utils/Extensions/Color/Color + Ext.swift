//
//  Color + Ext.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 04/06/24.
//

import Foundation
import SwiftUI

extension Color {
    init(value: String) {
        switch value {
        case "grass":
            self = .green
        case "fire":
            self = .red
        case "water":
            self = .blue
        case "electric":
            self = .yellow
        case "ice":
            self = .cyan
        case "fighting":
            self = .orange
        case "poison":
            self = .purple
        case "ground":
            self = .brown
        case "flying":
            self = .gray
        case "psychic":
            self = .pink
        case "bug":
            self = .green
        case "rock":
            self = .gray
        case "ghost":
            self = .purple
        case "dark":
            self = .black
        case "dragon":
            self = .purple
        case "steel":
            self = .gray
        case "fairy":
            self = .pink
        default:
            self = .gray
        }
    }
    
    func isLightColor() -> Bool {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return false
        }
        
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b
        return lum > 0.7
    }
}
