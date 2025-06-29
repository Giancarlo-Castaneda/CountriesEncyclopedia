import Foundation
import SwiftUI

@Observable
final class FavoriteListViewModel {

    private let dependencies: RootContainerProtocol

    /// Complete list fetched from SwiftData
    var countries: [FavoriteCountry] = [] {
        didSet { filterCountries() }
    }

    /// User search typed in SearchField
    var searchText: String = "" {
        didSet { filterCountries() }
    }

    /// Filtered list, displayed by the View
    var filteredCountries: [FavoriteCountry] = []
    var state: JobState = .empty

    // MARK: - Initialization

    init(dependencies: RootContainerProtocol) {
        self.dependencies = dependencies
        fetchSavedCountries()
    }

    // MARK: - Data Loading

    func fetchSavedCountries() {
        countries = dependencies.countryLocalRepository.fetchStoredCountries()
    }

    // MARK: - Filtering

    private func filterCountries() {
        state = .loading
        let term = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        if term.isEmpty {
            filteredCountries = countries
        } else {
            filteredCountries = countries.filter { fav in
                fav.name
                    .lowercased()
                    .contains(term)
            }
        }
        state = filteredCountries.isEmpty ? .empty : .success
    }

    // MARK: - Favorites Management

    func removeFavorite(_ country: FavoriteCountry) {
        dependencies.countryLocalRepository.removeCountry(country)
        dependencies.refreshLocalStorage()
        fetchSavedCountries()
    }

    func isFavorite(_ country: FavoriteCountry) -> Bool {
        dependencies.countryLocalRepository.isStored(country: country)
    }
}
