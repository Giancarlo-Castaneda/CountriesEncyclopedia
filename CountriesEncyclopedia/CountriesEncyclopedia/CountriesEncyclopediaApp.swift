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
            CountryListView(viewModel: CountryListViewModel(dependencies: rootDependecies))
        }
        .modelContainer(rootDependecies.localStore.modelContainer)
        .modelContext(rootDependecies.localStore.modelContext)
    }
}
