import Foundation
import Testing
@testable import CountriesEncyclopedia

struct CountryRestAPITests {

    private typealias SUT = CountryRestAPI

    @Test func example() async throws {
        let sut = SUT(path: "foo.path",
                      method: .post,
                      body: ["foo.body.key": "foo.body.value"],
                      queryItems: [URLQueryItem(name: "foo.query.1.name", value: "foo.query.1.value")])

        #expect(sut.path == "foo.path")
        #expect(sut.method == .post)
        #expect((sut.body?["foo.body.key"] as? String) == "foo.body.value")
        #expect(sut.queryItems?.first?.name == "foo.query.1.name")
        #expect(sut.queryItems?.first?.value == "foo.query.1.value")
    }
}
