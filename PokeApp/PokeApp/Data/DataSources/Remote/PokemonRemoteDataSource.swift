//
//  PokemonDataSource.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

protocol PokemonRemoteDataSource {
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse
    func getPokemonDetail(id: Int) async throws -> PokemonDetailResponse
    func catchPokemon() async throws -> PokemonCatchResponse
    func releasePokemon() async throws -> PokemonReleaseResponse
    func renamePokemon(nickname: String, sequence: Int) async throws -> PokemonRenameResponse
}

struct PokemonRemoteDataSourceImpl: PokemonRemoteDataSource {
    private let pokemonBaseURL = "https://pokeapi.co/api/v2/pokemon"
    private let pokeAppBaseURL = "http://192.168.100.6:3000/api"
    private let apiService: APIService
    
    init(apiService: APIService = APIServiceImpl()) {
        self.apiService = apiService
    }
    
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListResponse {
        guard let url = URL(string: "\(pokemonBaseURL)/?limit=\(limit)&offset=\(offset)") else { throw URLError(.badURL) }
        return try await apiService.fetch(from: url, timeoutInterval: nil)
    }
    
    func getPokemonDetail(id: Int) async throws -> PokemonDetailResponse {
        guard let url = URL(string: "\(pokemonBaseURL)/\(id)/") else { throw URLError(.badURL) }
        return try await apiService.fetch(from: url, timeoutInterval: nil)
    }
    
    func catchPokemon() async throws -> PokemonCatchResponse {
        guard let url = URL(string: "\(pokeAppBaseURL)/catch/") else { throw URLError(.badURL) }
        print("catchPokemon url: \(url)")
        return try await apiService.fetch(from: url, timeoutInterval: nil)
    }
    
    func releasePokemon() async throws -> PokemonReleaseResponse {
        guard let url = URL(string: "\(pokeAppBaseURL)/release/") else { throw URLError(.badURL) }
        return try await apiService.fetch(from: url, method: .post, timeoutInterval: nil)
    }
    
    func renamePokemon(nickname: String, sequence: Int) async throws -> PokemonRenameResponse {
          guard let url = URL(string: "\(pokeAppBaseURL)/rename/") else { throw URLError(.badURL) }
          let requestBody = PokemonRenameRequest(nickname: nickname, sequence: sequence)
          return try await apiService.fetch(from: url, method: .post, requestBody: requestBody, timeoutInterval: nil)
      }
}
