import SwiftUI

@Observable
final class CountryListViewModel {

    // MARK: - Private Properties

    private let dependencies: RootContainerProtocol

    // MARK: - Internal Properties

    var countryList: [CountryEntity] = []
    var searchText: String = ""
    var routing: NavigationPath = NavigationPath()
    var state: JobState = .empty

    // MARK: - Initialization

    init(dependencies: RootContainerProtocol) {
        self.dependencies = dependencies
    }

    // MARK: - Private Methods

    private func refreshFavorite(_ country: CountryEntity) {
        if let index = countryList.firstIndex(where: { $0.name == country.name }) {
            countryList[index].isFavorite.toggle()
        }
    }

    private func loadFavoriteCountries() {
        dependencies.appSession.favoriteCountries.forEach { favoriteCountry in
            if let index = countryList.firstIndex(where: { $0.name == favoriteCountry.name }) {
                countryList[index].isFavorite = true
            }
        }
    }

    // MARK: - Internal Methods

    func toogleFavorite(_ country: CountryEntity) {
        if dependencies.countryLocalRepository.isStored(country: country) {
            dependencies.countryLocalRepository.removeCountry(country)
        } else {
            dependencies.countryLocalRepository.addCountry(country)
        }
        dependencies.refreshLocalStorage()
        refreshFavorite(country)
        loadFavoriteCountries()
    }

    func isFavorite(_ country: CountryEntity) -> Bool {
        dependencies.countryLocalRepository.isStored(country: country)
    }

    func search(by name: String) {
        Task {
            do {
                countryList = try await dependencies.countryRepository.fetchCountries(by: name)
                loadFavoriteCountries()
            } catch {
                debugPrint(error)
            }
        }
    }

    func loadCountries() async {
        do {
            state = .loading
            countryList = try await dependencies.countryRepository.fetchCountries()
            loadFavoriteCountries()
            state = .success
        } catch {
            state = .failure
            debugPrint(error)
        }
    }

    func makeDetailViewModel(for country: CountryEntity) -> CountryDetailViewModel {
        CountryDetailViewModel(dependencies: dependencies, country: country) { [weak self] country in
            self?.refreshFavorite(country)
        }
    }
}
