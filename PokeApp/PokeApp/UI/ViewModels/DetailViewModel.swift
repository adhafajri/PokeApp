//
//  DetailViewModel.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation
import SwiftUI

@MainActor
class DetailViewModel: ObservableObject {
    private let repository: PokemonRepository
    
    @Published var pokemon: PokemonModel
    
    @Published var isEditing = false
    @Published var nickname: String
    
    @Published var showCatchResult = false
    @Published var showReleaseResult = false
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    init(
        repository: PokemonRepository = PokemonRepositoryImpl(),
        pokemon: PokemonModel
    ) {
        self.repository = repository
        self.pokemon = pokemon
        self.nickname = pokemon.detail?.nickname ?? ""
    }
    
    func fetchPokemonDetail() async {
        let isOwned = pokemon.isOwned
        if isOwned { return }
        
        let pokemonId = pokemon.pokemonId
        
        do {
            let pokemon = try await repository.fetchPokemonDetail(id: pokemonId)
            
            withAnimation(.bouncy) {
                self.pokemon = pokemon
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func catchPokemon() async {
        do {
            let pokemon = try await repository.catchPokemon(pokemon: pokemon)
            
            withAnimation(.bouncy) {
                self.pokemon = pokemon
                self.showCatchResult = true
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func releasePokemon() async {
        do {
            let pokemon = try await repository.releasePokemon(pokemon: pokemon)
            
            withAnimation(.bouncy) {
                self.pokemon = pokemon
                self.showReleaseResult = true
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func renamePokemon(nickname: String, sequence: Int) async {
        do {
            let pokemon = try await repository.renamePokemon(pokemon: pokemon, nickname: nickname, sequence: sequence)
            
            withAnimation(.bouncy) {
                self.pokemon = pokemon
                self.isEditing = false
                self.nickname = pokemon.detail?.nickname ?? ""
            }
            
            print("Pokemon is renamed!")
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func toggleEditing() {
        withAnimation(.bouncy) {
            isEditing.toggle()
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
    
    func dismissAlert() {
        alertMessage = ""
        showAlert = false
    }
}
