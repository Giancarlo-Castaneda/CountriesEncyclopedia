// CountryRepositoryTests.swift

import Testing
@testable import CountriesEncyclopedia

private final class MockNetworkingProvider: NetworkingProvider {
    var stubbedDTOs: [CountryDTO] = []
    var stubbedError: Error?

    func sendRequest(endpoint: RequestType) async throws {
        if let error = stubbedError { throw error }
    }

    func sendRequest<T: Decodable>(
        endpoint: RequestType,
        responseModel: T.Type
    ) async throws -> T {
        if let error = stubbedError { throw error }
        return stubbedDTOs as! T
    }
}

struct CountryRepositoryTests {
    private var mockNet = MockNetworkingProvider()
    private var repo: ConcreteCountryRepository {
        ConcreteCountryRepository(networkingProvider: mockNet)
    }

    @Test
    func testFetchAllCountriesMapsCorrectly() async throws {
        let dto1 = CountryDTO.mock
        let dto2 = CountryDTO.mock
        mockNet.stubbedDTOs = [dto1, dto2]

        let result = try await repo.fetchCountries()
        #expect(result.count == 2)
        #expect(result[1].name == "foo.common")
        #expect(result[1].capital == "foo.capital.1, foo.capital.2")
    }

    @Test
    func testFetchByNameUsesNetworkingAndMaps() async throws {
        let dto = CountryDTO.mock
        mockNet.stubbedDTOs = [dto]

        let result = try await repo.fetchCountries(by: "anything")
        #expect(result.count == 1)
        #expect(result[0].name == "foo.common")
        #expect(result[0].capital == "foo.capital.1, foo.capital.2")
    }

    @Test
    func testFetchThrowsErrorWhenNetworkingFails() async throws {
        mockNet.stubbedError = RequestError.noResponse

        await #expect(throws: RequestError.noResponse, performing: {
            try await repo.fetchCountries()
        })
    }
}
