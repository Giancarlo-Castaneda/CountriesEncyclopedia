import SwiftUI

@Observable
final class CountryListViewModel {

    // MARK: - Private Properties

    private let dependencies: RootContainerProtocol

    // MARK: - Internal Properties

    var countryList: [CountryEntity] = []
    var searchText: String = ""
    var routing: NavigationPath = NavigationPath()

    // MARK: - Initialization

    init(dependencies: RootContainerProtocol) {
        self.dependencies = dependencies
    }

    // MARK: - Internal Methods

    func toogleFavorite(_ country: CountryEntity) {
        if dependencies.countryLocalRepository.isStored(country: country) {
            dependencies.countryLocalRepository.removeCountry(country)
        } else {
            dependencies.countryLocalRepository.addCountry(country)
        }
        if let index = countryList.firstIndex(of: country) {
            countryList[index].isSaved.toggle()
        }
    }

    func isFavorite(_ country: CountryEntity) -> Bool {
        dependencies.countryLocalRepository.isStored(country: country)
    }

    func search(by name: String) {
        Task {
            do {
                countryList = try await dependencies.countryRepository.fetchCountries(by: name)
            } catch {
                debugPrint(error)
            }
        }
    }

    func loadCountries() {
        Task {
            do {
                countryList = try await dependencies.countryRepository.fetchCountries()
            } catch {
                debugPrint(error)
            }
        }
    }
}
