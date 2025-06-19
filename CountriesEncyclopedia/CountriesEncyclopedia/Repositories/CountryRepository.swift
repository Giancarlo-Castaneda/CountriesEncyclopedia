import Foundation

protocol CountryRepository {

    func fetchCountries() async throws -> [CountryEntity]
    func fetchCountries(by name: String) async throws -> [CountryEntity]
}

final class ConcreteCountryRepository: CountryRepository {

    // MARK: - Private Properties

    private let networkingProvider: NetworkingProvider

    // MARK: - Initialization

    init(networkingProvider: NetworkingProvider) {
        self.networkingProvider = networkingProvider
    }

    // MARK: - Internal Methods

    func fetchCountries() async throws -> [CountryEntity] {
        let endpoint = CountryRestAPI.countryListGET()
        let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: [CountryDTO].self)

        return dto.map { CountryEntity($0) }
    }

    func fetchCountries(by name: String) async throws -> [CountryEntity] {
        let endpoint = CountryRestAPI.countryGET(by: name)
        let dto = try await networkingProvider.sendRequest(endpoint: endpoint, responseModel: [CountryDTO].self)

        return dto.map { CountryEntity($0) }
    }
}
