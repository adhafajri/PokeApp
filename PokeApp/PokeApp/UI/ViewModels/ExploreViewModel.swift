//
//  ExploreViewModel.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation
import SwiftUI

@MainActor
class ExploreViewModel: ObservableObject {
    private let repository: PokemonRepository
    
    @Published var pokemonList = [PokemonModel]()
    @Published var offset = 20
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }
    
    func fetchPokemonList() async {
        do {
            let pokemons = try await repository.fetchPokemonList(limit: 20, offset: offset)
            
            withAnimation(.bouncy) {
                pokemonList.append(contentsOf: pokemons)
            }
        } catch {
            showAlert(message: error.localizedDescription)
        }
    }
    
    func handleOnPokemonListAppear(pokemon: PokemonModel) async {
        guard pokemonList.last == pokemon else { return }
        
        increaseOffset(value: 20)
        await fetchPokemonList()
    }
    
    func increaseOffset(value: Int) {
        withAnimation(.bouncy) {
            offset += value
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
