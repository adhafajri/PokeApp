//
//  MyPokemonListView.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import SwiftUI

struct MyPokemonListView: View {
    @StateObject var viewModel = MyPokemonListViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.pokemonList) { pokemon in
                    NavigationLink(destination: DetailView(pokemon: pokemon)) {
                        PokemonItemView(pokemon: pokemon)
                    }
                }
            }
            .padding()
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
                viewModel.dismissAlert()
            }
        }
        .onAppear {
            viewModel.fetchMyPokemonList()
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
                viewModel.dismissAlert()
            }
        }
    }
}

#Preview {
    MyPokemonListView()
}
