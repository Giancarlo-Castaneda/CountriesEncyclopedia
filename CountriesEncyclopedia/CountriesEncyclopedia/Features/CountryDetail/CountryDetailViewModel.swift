import Foundation

@Observable
final class CountryDetailViewModel {

    // MARK: - Private Propeties

    private var dependencies: RootContainerProtocol

    // MARK: - Internal Properties

    var country: CountryEntity
    var onToogleFavorite: ((CountryEntity) -> Void)?

    // MARK: - Initialization
    
    init(dependencies: RootContainerProtocol,
         country: CountryEntity,
         onToogleFavorite: ((CountryEntity) -> Void)? = nil) {

        self.dependencies = dependencies
        self.country = country
        self.onToogleFavorite = onToogleFavorite
        isCountryFavorited()
    }
    
    // MARK: - Private Methods

    private func isCountryFavorited() {
        country.isFavorite = dependencies.countryLocalRepository.isStored(country: country)
    }

    // MARK: - Internal Methods

    func toogleFavorite() {
        if dependencies.countryLocalRepository.isStored(country: country) {
            dependencies.countryLocalRepository.removeCountry(country)
        } else {
            dependencies.countryLocalRepository.addCountry(country)
        }
        dependencies.refreshLocalStorage()
        isCountryFavorited()
        onToogleFavorite?(country)
    }
}
