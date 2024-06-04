//
//  ContentView.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ExploreView()
                    .tabItem {
                        Image(.compass)
                            .resizable()
                        Text("Explore")
                            .foregroundColor(selectedTab == 0 ? .primary : .gray)
                    }
                    .tag(0)
                
                MyPokemonListView()
                    .tabItem {
                        Image(.backpack)
                            .resizable()
                        Text("My Pokémon List")
                            .foregroundColor(selectedTab == 1 ? .primary : .gray)
                    }
                    .tag(1)
            }
        }
    }
}

#Preview {
    ContentView()
}
