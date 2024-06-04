//
//  PokemonDetailEntity.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation

struct PokemonDetailModel: Equatable {
    var nickname: String?
    let types: [String]
    let abilities: [String]
    let moves: [String]
    
    init(nickname: String? = nil, types: [String], abilities: [String], moves: [String]) {
        self.nickname = nickname
        self.types = types
        self.abilities = abilities
        self.moves = moves
    }
    
    mutating func updateNickname(_ nickname: String) {
        self.nickname = nickname
    }
}
