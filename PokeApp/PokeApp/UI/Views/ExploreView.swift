//
//  ExploreView.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import SwiftUI

struct ExploreView: View {
    @StateObject var viewModel: ExploreViewModel = ExploreViewModel()
    
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
                    .task {
                        await viewModel.handleOnPokemonListAppear(pokemon: pokemon)
                    }
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchPokemonList()
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
                viewModel.dismissAlert()
            }
        }
    }
}

#Preview {
    ExploreView()
}
