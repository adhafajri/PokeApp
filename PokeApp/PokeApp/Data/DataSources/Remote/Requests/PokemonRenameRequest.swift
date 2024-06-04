//
//  PokemonRenameRequest.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

struct PokemonRenameRequest: Encodable {
    let nickname: String
    let sequence: Int
}
