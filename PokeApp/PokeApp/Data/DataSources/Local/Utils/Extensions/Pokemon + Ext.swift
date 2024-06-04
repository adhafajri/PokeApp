//
//  Pokemon + Ext.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation
import CoreData

extension Pokemon {
    convenience init(
        context: NSManagedObjectContext,
        pokemon: PokemonModel
    ) throws {
        self.init(context: context)
        self.id = pokemon.id
        self.pokemonId = Int32(pokemon.pokemonId)
        self.name = pokemon.name
        self.imageURL = pokemon.imageURL
        
        guard let detail = pokemon.detail else {
            throw NSError(domain: "PokemonModel", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get detail"])
        }
        
        self.nickname = detail.nickname
        self.types = try Data(array: detail.types)
        self.abilities = try Data(array: detail.abilities)
        self.moves = try Data(array: detail.moves)
        self.renameSequence = Int32(pokemon.renameSequence ?? 0)
    }
    
    func updateNickname(
        nickname: String
    ) {
        self.nickname = nickname
        self.renameSequence = renameSequence + 1
    }
}
