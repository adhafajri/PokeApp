//
//  PokemonRepositories.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

protocol PokemonRepository {
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [PokemonModel]
    func fetchMyPokemonList() throws -> [PokemonModel]
    func fetchPokemonDetail(id: Int) async throws -> PokemonModel
    func catchPokemon(pokemon: PokemonModel) async throws -> PokemonModel
    func renamePokemon(pokemon: PokemonModel, nickname: String, sequence: Int) async throws -> PokemonModel
    func releasePokemon(pokemon: PokemonModel) async throws -> PokemonModel
}

struct PokemonRepositoryImpl: PokemonRepository {
    private let localDataSource: PokemonLocalDataSource
    private let remoteDataSource: PokemonRemoteDataSource
    
    init(
        localDataSource: PokemonLocalDataSource = PokemonLocalDataSourceImpl(),
        remoteDataSource: PokemonRemoteDataSource = PokemonRemoteDataSourceImpl()
    ) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    func fetchPokemonList(limit: Int, offset: Int) async throws -> [PokemonModel] {
        let resp = try await remoteDataSource.getPokemonList(limit: limit, offset: offset)
        let pokemons = resp.results
        return try pokemons.map { response in try PokemonModel(response: response) }
    }
    
    func fetchMyPokemonList() throws -> [PokemonModel] {
        return try localDataSource.getPokemons()
    }
    
    func fetchPokemonDetail(id: Int) async throws -> PokemonModel {
        let resp = try await remoteDataSource.getPokemonDetail(id: id)
        return PokemonModel(response: resp)
    }
    
    func catchPokemon(pokemon: PokemonModel) async throws -> PokemonModel {
        let resp = try await remoteDataSource.catchPokemon()
        guard resp.success else { return pokemon }
        return try localDataSource.savePokemon(pokemon: pokemon)
    }
    
    func renamePokemon(pokemon: PokemonModel, nickname: String, sequence: Int) async throws -> PokemonModel {
        let resp = try await remoteDataSource.renamePokemon(nickname: nickname, sequence: sequence)
        let newName = resp.newName
        return try localDataSource.renamePokemon(pokemon: pokemon, nickname: newName)
    }
    
    func releasePokemon(pokemon: PokemonModel) async throws -> PokemonModel {
        let resp = try await remoteDataSource.releasePokemon()
        let number = resp.number
        guard number.isPrime() else { return pokemon }
        
        return try localDataSource.deletePokemon(pokemon: pokemon)
    }
}
