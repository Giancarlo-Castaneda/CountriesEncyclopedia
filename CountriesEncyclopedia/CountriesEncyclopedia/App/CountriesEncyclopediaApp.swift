//
//  CountriesEncyclopediaApp.swift
//  CountriesEncyclopedia
//
//  Created by Giancarlo Castañeda Garcia on 17/06/25.
//

import SwiftUI
import SwiftData

@main
struct CountriesEncyclopediaApp: App {

    private let rootDependecies: RootContainerProtocol = RootDependencies()

    var body: some Scene {
        WindowGroup {
            TabView {
                Tab {
                    CountryListView(viewModel: CountryListViewModel(dependencies: rootDependecies))
                } label: {
                    Label("SEARCH_TAB_TITLE", systemImage: "magnifyingglass")
                }
                Tab {
                    FavoriteListView(viewModel: FavoriteListViewModel(dependencies: rootDependecies))
                } label: {
                    Label("FAVORITES_TAB_TITLE", systemImage: "star")
                }
            }
        }
        .modelContainer(rootDependecies.localStore.modelContainer)
        .modelContext(rootDependecies.localStore.modelContext)
    }
}
