import SwiftUI

@Observable
final class CountryListViewModel {

    private let repository = ConcreteCountryRepository(networkingProvider: networkingProvider)

    var countryList: [CountryEntity] = []
    var favorites: Set<String> = []
    var searchText: String = ""

    func toogleFavorite(_ country: CountryEntity) {
        if favorites.contains(country.name) {
            favorites.remove(country.name)
        } else {
            favorites.insert(country.name)
        }
    }

    func isFavorite(_ country: CountryEntity) -> Bool {
        favorites.contains(country.name)
    }

    func search(by name: String) {
        Task {
            do {
                countryList = try await repository.fetchCountries(by: name)
            } catch {
                debugPrint(error)
            }
        }
    }

    func loadCountries() {
        Task {
            do {
                countryList = try await repository.fetchCountries()
            } catch {
                debugPrint(error)
            }
        }
    }
}
