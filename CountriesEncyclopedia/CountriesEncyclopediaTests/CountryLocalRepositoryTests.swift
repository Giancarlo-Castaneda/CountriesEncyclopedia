import Foundation
import SwiftData
import Testing
@testable import CountriesEncyclopedia

struct CountryLocalRepositoryTests {
    // SUT: repo local en memoria
    private var localStore: LocalStore {
        // override in-memory configuración para tests
        var store = LocalStore()
        // sustituye el modelContainer por uno in-memory
        let schema = Schema([FavoriteCountry.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        _ = try! ModelContainer(for: schema, configurations: [config])
        // manualmente injecContext en store
        store = LocalStore()
        store = LocalStore() // si fuese mutable
        return store
    }

    private func makeRepo() -> ConcreteCountryLocalRepository {
        ConcreteCountryLocalRepository(localStore: localStore)
    }

    @Test
    func testFetchEmptyInitially() {
        let repo = makeRepo()
        let all = repo.fetchStoredCountries()
        #expect(all.isEmpty)
    }

    @Test
    func testAddCountryStoresIt() {
        let repo = makeRepo()
        let country = CountryEntity(.mock)
        repo.addCountry(country)
        #expect(repo.isStored(country: country))
        let all = repo.fetchStoredCountries()
        #expect(all.count == 1)
        #expect(all.first?.name == country.name)
    }

    @Test
    func testRemoveCountryDeletesIt() {
        let repo = makeRepo()
        let country = CountryEntity(.mock)
        repo.addCountry(country)
        #expect(repo.isStored(country: country))

        repo.removeCountry(country)
        #expect(!repo.isStored(country: country))
        #expect(repo.fetchStoredCountries().isEmpty)
    }
}
