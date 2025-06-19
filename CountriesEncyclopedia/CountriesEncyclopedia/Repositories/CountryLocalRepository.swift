import Foundation
import SwiftData

protocol CountryLocalRepository {

    func fetchStoredCountries() -> [FavoriteCountry]
    func addCountry(_ country: CountryEntity)
    func removeCountry(_ country: CountryRowData)
    func isStored(country: CountryRowData) -> Bool
}

struct ConcreteCountryLocalRepository: CountryLocalRepository {

    // MARK: - Private Properties

    private let localStore: LocalStore

    // MARK: - Initialization

    init(localStore: LocalStore) {
        self.localStore = localStore
    }

    // MARK: - Internal Methods

    func fetchStoredCountries() -> [FavoriteCountry] {
        do {
            return try localStore.modelContext.fetch(FetchDescriptor<FavoriteCountry>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addCountry(_ country: CountryEntity) {
        let favoriteCountry = FavoriteCountry(commonName: country.name,
                                              officialName: country.officialName,
                                              capital: country.capital,
                                              flagUrl: country.flagURL,
                                              flagAltText: country.flagAltText)
        localStore.modelContext.insert(favoriteCountry)
        localStore.saveContext()
    }
    
    func removeCountry(_ country: CountryRowData) {
        do {
            let nameToRemove = country.name

            let fetch = FetchDescriptor<FavoriteCountry>(
                predicate: #Predicate { item in
                    item.name == nameToRemove
                }
            )
            let saved = try localStore.modelContext.fetch(fetch)
            for country in saved {
                localStore.modelContext.delete(country)
            }
            
            localStore.saveContext()
        } catch {
            assertionFailure(error.localizedDescription)
        }
    }
    
    func isStored(country: CountryRowData) -> Bool {
        do {
            return try localStore.modelContext.fetch(FetchDescriptor<FavoriteCountry>())
                .contains(where: { $0.name == country.name })

        } catch {
            assertionFailure(error.localizedDescription)
            return false
        }
    }
}
