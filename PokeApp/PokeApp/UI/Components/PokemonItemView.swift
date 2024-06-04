//
//  PokemonItemView.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 03/06/24.
//

import SwiftUI

struct PokemonItemView: View {
    var pokemon: PokemonModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 72)
            } placeholder: {
                ProgressView()
            }
            
            
            Text(pokemon.detail?.nickname ?? pokemon.name.capitalized)
                .font(.title3)
                .foregroundColor(.black)
                .padding()
        }
        .frame(height: 140)
        .background(RoundedRectangle(
            cornerRadius: 16)
            .fill(Color.white)
            .shadow(radius: 1)
            .blur(radius: 1)
        )
        .padding(.horizontal, 2)
    }
}

#Preview {
    PokemonItemView(pokemon: PokemonModel.dummyData())
}
