//
//  PokemonModel + Ext.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation

extension PokemonModel {
    static func dummyData() -> PokemonModel {
        PokemonModel(
            id: UUID(),
            pokemonId: 1,
            name: "Bulbasaur",
            imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
            detail: PokemonDetailModel(
                types: ["Grass", "Poison"],
                abilities: ["Overgrow", "Chlorophyll"],
                moves: ["Tackle", "Growl", "Leech Seed", "Vine Whip"]
            ),
            isOwned: false
        )
    }
}
