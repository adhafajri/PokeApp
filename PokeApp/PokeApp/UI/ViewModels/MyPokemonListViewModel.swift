//
//  InventoryViewModel.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import Foundation
import SwiftUI

@MainActor
class MyPokemonListViewModel: ObservableObject {
    private let repository: PokemonRepository
    
    @Published var pokemonList = [PokemonModel]()
    
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }
    
    func fetchMyPokemonList() {
        do {
            let pokemons = try repository.fetchMyPokemonList()
            
            withAnimation(.bouncy) {
                pokemonList = pokemons
            }
        } catch {
            showAlert(message: error.localizedDescription)
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
