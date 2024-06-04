// DetailView.swift
// PokeApp
//
// Created by Muhammad Adha Fajri Jonison on 03/06/24.
//
import SwiftUI

struct DetailView: View {
    @StateObject var viewModel: DetailViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(pokemon: PokemonModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(pokemon: pokemon))
    }
    
    var body: some View {
        Group {
            if viewModel.showCatchResult {
                VStack {
                    Image(viewModel.pokemon.isOwned ? .gotcha : .footprints)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text(viewModel.pokemon.isOwned ? "You caught \(viewModel.pokemon.name)!" : "You missed \(viewModel.pokemon.name)!")
                        .font(.title)
                        .padding()
                    
                    Text(viewModel.pokemon.isOwned ? "Gotta catch 'em all!" : "\(viewModel.pokemon.name) ran away...")
                        .font(.headline)
                        .padding()
                    
                    Button {
                        withAnimation(.bouncy) {
                            viewModel.showCatchResult.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                            .padding(32)
                            .background(Color.yellow)
                            .cornerRadius(24)
                    }
                }
                .transition(.asymmetric(insertion: .scale(scale: 0.5, anchor: .center), removal: .opacity))
            } else if viewModel.showReleaseResult {
                VStack {
                    Image(.footprints)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text(viewModel.pokemon.isOwned ? "Failed to release \(viewModel.pokemon.detail?.nickname ?? viewModel.pokemon.name)!" : "You've released \(viewModel.pokemon.detail?.nickname ?? viewModel.pokemon.name)!")
                        .font(.title)
                        .padding()
                    
                    Text(viewModel.pokemon.isOwned ? "\(viewModel.pokemon.detail?.nickname ?? viewModel.pokemon.name) won't leave..." : "Goodbye, \(viewModel.pokemon.detail?.nickname ?? viewModel.pokemon.name)!")
                        .font(.headline)
                        .padding()
                    
                    Button {
                        withAnimation(.bouncy) {
                            viewModel.showReleaseResult.toggle()
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                            .padding(32)
                            .background(Color.yellow)
                            .cornerRadius(24)
                    }
                }
                .transition(.asymmetric(insertion: .scale(scale: 0.5, anchor: .center), removal: .opacity))
            } else {
                ZStack {
                    ScrollView {
                        VStack {
                            AsyncImage(url: URL(string: viewModel.pokemon.imageURL)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 200)
                            .padding()
                            
                            if viewModel.pokemon.isOwned {
                                HStack(spacing: 0) {
                                    if viewModel.isEditing {
                                        TextField("Nickname", text: $viewModel.nickname)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.white)
                                                .shadow(radius: 1)
                                                .blur(radius: 1)
                                            )
                                            .padding(.leading)
                                            .padding()
                                    } else {
                                        Text(viewModel.nickname)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(RoundedRectangle(cornerRadius: 16)
                                                .fill(Color.white)
                                                .shadow(radius: 1)
                                                .blur(radius: 1)
                                            )
                                            .padding()
                                    }
                                    
                                    Button{
                                        if viewModel.isEditing {
                                            Task {
                                                await viewModel.renamePokemon(nickname: viewModel.nickname, sequence: viewModel.pokemon.renameSequence ?? 0)
                                            }
                                        } else {
                                            viewModel.toggleEditing()
                                        }
                                    } label: {
                                        Image(systemName: viewModel.isEditing ? "checkmark" : "pencil")
                                            .resizable()
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(.black)
                                            .padding()
                                            .background(Color.yellow)
                                            .cornerRadius(20)
                                            .padding(.trailing)
                                    }
                                }
                            }
                            
                            if let types = viewModel.pokemon.detail?.types {
                                LazyVGrid(columns: columns, spacing: 16) {    ForEach(types, id: \.self) { type in
                                    Text(type.capitalized)
                                        .padding()
                                        .background(Color(value: type))
                                        .foregroundColor(Color(value: type).isLightColor() ? .black : .white)
                                        .cornerRadius(10)
                                }
                                }
                            }
                            
                            if let abliities = viewModel.pokemon.detail?.abilities {
                                Text("ABILITIES")
                                    .font(.headline)
                                    .padding()
                                
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(abliities, id: \.self) { ability in
                                        Text(ability.capitalized)
                                            .padding()
                                            .background(RoundedRectangle(
                                                cornerRadius: 16)
                                                .fill(Color.white)
                                                .shadow(radius: 1)
                                                .blur(radius: 1)
                                            )
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            if let moves = viewModel.pokemon.detail?.moves {
                                Text("MOVES")
                                    .font(.headline)
                                    .padding()
                                
                                LazyVGrid(columns: columns, spacing: 16) {
                                    ForEach(moves, id: \.self) { move in
                                        Text(move.capitalized)
                                            .padding()
                                            .background(RoundedRectangle(
                                                cornerRadius: 16)
                                                .fill(Color.white)
                                                .shadow(radius: 1)
                                                .blur(radius: 1)
                                            )
                                    }
                                }
                                
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    VStack {
                        Spacer()
                        
                        Button{
                            Task {
                                if viewModel.pokemon.isOwned {
                                    await viewModel.releasePokemon()
                                } else {
                                    await viewModel.catchPokemon()
                                }
                            }
                        } label: {
                            VStack {
                                Image(viewModel.pokemon.isOwned ? .openPokeball : .pokeball)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.red)
                                
                                Text(viewModel.pokemon.isOwned ? "Release" : "Catch")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            .padding(24)
                            .background(RoundedRectangle(
                                cornerRadius: 24)
                                .fill(Color.white)
                                .shadow(radius: 4)
                                .blur(radius: 1)
                            )
                        }
                    }
                }
                .transition(.asymmetric(insertion: .scale(scale: 1.5, anchor: .center), removal: .opacity))
                .navigationTitle(viewModel.pokemon.name)
                .task {
                    await viewModel.fetchPokemonDetail()
                }
                .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
                    Button("OK", role: .cancel) {
                        viewModel.dismissAlert()
                    }
                }
            }
            
        }
    }
}

#Preview {
    DetailView(pokemon: PokemonModel.dummyData())
}
