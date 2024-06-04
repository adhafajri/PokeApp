//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResponse]
}

struct PokemonResponse: Decodable {
    let name: String
    let url: String
}
