//
//  PokemonDetailResponse.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let id: Int
    let name: String
    let abilities: [PokemonAbilityResponse]
    let moves: [PokemonMoveResponse]
    let types: [PokemonTypeResponse]
}

struct PokemonAbilityResponse: Decodable {
    let ability: PokemonAbilityDetailResponse
}

struct PokemonAbilityDetailResponse: Decodable {
    let name: String
}

struct PokemonMoveResponse: Decodable {
    let move: PokemonMoveDetailResponse
}

struct PokemonMoveDetailResponse: Decodable {
    let name: String
}

struct PokemonTypeResponse: Decodable {
    let type: PokemonTypeDetailResponse
}

struct PokemonTypeDetailResponse: Decodable {
    let name: String
}
