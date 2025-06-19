//
//  RootContainer.swift
//  CountriesEncyclopedia
//
//  Created by Giancarlo Castañeda Garcia on 18/06/25.
//

import Foundation

protocol RootContainerProtocol {
    var localStore: LocalStore { get }
    var countryRepository: CountryRepository { get }
    var countryLocalRepository: CountryLocalRepository { get }
}

@Observable
final class RootDependencies: RootContainerProtocol {
    let localStore: LocalStore
    let countryRepository: CountryRepository
    let countryLocalRepository: CountryLocalRepository

    init() {
        self.localStore = LocalStore()
        let networkingProvider = ConcreteNetworkingProvider(jsonDecoder: RootDependencies.jsonDecoder())
        self.countryRepository = ConcreteCountryRepository(networkingProvider: networkingProvider)
        self.countryLocalRepository = ConcreteCountryLocalRepository(localStore: localStore)
    }

    private static func jsonDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
