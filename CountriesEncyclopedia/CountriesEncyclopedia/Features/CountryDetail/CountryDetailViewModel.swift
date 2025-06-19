import Foundation

@Observable
final class CountryDetailViewModel {

    private var dependencies: RootContainerProtocol
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
    
    // MARK: - Methods

    fileprivate func isCountryFavorited() {
        country.isFavorite = dependencies.countryLocalRepository.isStored(country: country)
    }
    
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
