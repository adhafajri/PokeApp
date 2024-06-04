//
//  PokemonModel.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation
import SwiftUI

struct PokemonModel: Identifiable, Equatable {
    let id: UUID
    let pokemonId: Int
    let name: String
    let imageURL: String
    var detail: PokemonDetailModel?
    var renameSequence: Int?
    var isOwned: Bool = false
    
    init(
        id: UUID,
        pokemonId: Int,
        name: String,
        imageURL: String,
        detail: PokemonDetailModel? = nil,
        renameSequence: Int? = 0,
        isOwned: Bool
    ) {
        self.id = id
        self.pokemonId = pokemonId
        self.name = name
        self.imageURL = imageURL
        self.detail = detail
        self.renameSequence = renameSequence
        self.isOwned = isOwned
    }
    
    init(pokemon: Pokemon) throws {
        guard let id = pokemon.id else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get id"])
        }
        self.id = id
        self.pokemonId = Int(pokemon.pokemonId)
        
        guard let name = pokemon.name else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get name"])
        }
        self.name = name
        
        guard let imageURL = pokemon.imageURL else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get image"])
        }
        self.imageURL = imageURL
        
        guard let typesData = pokemon.types else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get types"])
        }
        let types = try Array<String>(data: typesData)
        
        guard let abilitiesData = pokemon.abilities else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get abilities"])
        }
        let abilities = try Array<String>(data: abilitiesData)
        
        guard let movesData = pokemon.moves else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get moves"])
        }
        let moves = try Array<String>(data: movesData)
        
        let nickname = pokemon.nickname
        self.detail = PokemonDetailModel(nickname: nickname, types: types, abilities: abilities, moves: moves)
        
        self.renameSequence = Int(pokemon.renameSequence)
        self.isOwned = true
        
    }
    
    init(response: PokemonResponse) throws {
        guard let urlComponents = URLComponents(string: response.url),
              let idString = urlComponents.path.split(separator: "/").last,
              let id = Int(idString) else {
            throw NSError(domain: "PokemonEntity", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get id"])
        }
        
        self.id = UUID()
        self.pokemonId = id
        self.name = response.name
        self.imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png"
        
        self.isOwned = false
    }
    
    init(response: PokemonDetailResponse) {
        self.id = UUID()
        self.pokemonId = response.id
        self.name = response.name
        self.imageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(response.id).png"
        
        self.detail = PokemonDetailModel(
            types: response.types.map { $0.type.name },
            abilities: response.abilities.map { $0.ability.name },
            moves: response.moves.map { $0.move.name }
        )
        self.isOwned = false
    }
    
    mutating func capture() {
        isOwned = true
    }
    
    mutating func release() {
        isOwned = false
    }
    
    mutating func rename(nickname: String) {
        detail?.updateNickname(nickname)
        renameSequence = (renameSequence ?? 0) + 1
    }
}
