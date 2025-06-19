import Foundation
import Testing
@testable import CountriesEncyclopedia

private struct FullEndpoint: RequestType {
    var path: String = "/v1/endpoint"
    var method: HTTPMethod = .post
    var headers: [String: String] = [:]
    var body: [String: Any]? = ["k":"v"]
    var queryItems: [URLQueryItem]? = [URLQueryItem(name:"q", value:"x")]
    var port: Int? = nil
    var version: String { "/v3.1" }
}

struct RequestBuilderTests {
    private let builder = ConcreteRequestBuilder()

    @Test
    func testMakeRequestWithAllComponents() throws {
        let ep = FullEndpoint()
        let req = try builder.makeRequest(endpoint: ep)
        #expect(req.httpMethod == "POST")
        #expect(req.url?.absoluteString.contains("restcountries.com/v3.1/v1/endpoint") == true)
        #expect(req.url?.query?.contains("q=x") == true)
        let body = try JSONSerialization.jsonObject(with: req.httpBody!) as? [String:String]
        #expect(body?["k"] == "v")
    }

    @Test
    func testInvalidURLThrows() throws {
        struct Bad: RequestType {
            var scheme: String { "https" }
            var host: String { "  " }   // inválido
            var path: String { "" }
            var method: HTTPMethod { .get }
            var headers: [String:String] { [:] }
            var body: [String:Any]? { nil }
            var queryItems: [URLQueryItem]? { nil }
            var port: Int? { nil }
            var version: String { "" }
        }
        #expect(throws: RequestError.invalidURL) {
            try builder.makeRequest(endpoint: Bad())
        }
    }
}
