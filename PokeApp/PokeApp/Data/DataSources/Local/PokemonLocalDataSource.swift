//
//  PokemonLocalDataSource.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

protocol PokemonLocalDataSource {
    func getPokemons() throws -> [PokemonModel]
    func savePokemon(pokemon: PokemonModel) throws -> PokemonModel
    func renamePokemon(pokemon: PokemonModel, nickname: String) throws -> PokemonModel
    func deletePokemon(pokemon: PokemonModel) throws -> PokemonModel
}

class PokemonLocalDataSourceImpl: PokemonLocalDataSource {
    private let coreDataService: CoreDataService
    
    init(
        coreDataService: CoreDataService = CoreDataServiceImpl()
    ) {
        self.coreDataService = coreDataService
    }
    
    func getPokemons() throws -> [PokemonModel] {
        let request = Pokemon.fetchRequest()
        let pokemons = try coreDataService.fetch(request: request)
        return try pokemons.map { try PokemonModel(pokemon: $0) }
    }
    
    func savePokemon(pokemon: PokemonModel) throws -> PokemonModel {
        var pokemon = pokemon
        
        let _ = try Pokemon(
            context: coreDataService.container.viewContext,
            pokemon: pokemon
        )
        
        try coreDataService.save()
        pokemon.capture()
        
        return pokemon
    }
    
    func renamePokemon(pokemon: PokemonModel, nickname: String) throws -> PokemonModel {
        var pokemon = pokemon
        
        let request = Pokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", pokemon.id as CVarArg)
        guard let pokemonEntity = try coreDataService.fetch(request: request).first else {
            throw NSError(domain: "PokemonLocalDataSource", code: 0, userInfo: [NSLocalizedDescriptionKey: "Pokemon not found"])
        }
        
        pokemonEntity.updateNickname(nickname: nickname)
        try coreDataService.save()
        
        pokemon = try PokemonModel(pokemon: pokemonEntity)
        
        return pokemon
    }
    
    func deletePokemon(pokemon: PokemonModel) throws -> PokemonModel {
        var pokemon = pokemon
        
        let request = Pokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", pokemon.id as CVarArg)
        guard let pokemonEntity = try coreDataService.fetch(request: request).first else {
            throw NSError(domain: "PokemonLocalDataSource", code: 0, userInfo: [NSLocalizedDescriptionKey: "Pokemon not found"])
        }
        
        try coreDataService.delete(object: pokemonEntity)
        pokemon.release()
        
        return pokemon
    }
    
}
