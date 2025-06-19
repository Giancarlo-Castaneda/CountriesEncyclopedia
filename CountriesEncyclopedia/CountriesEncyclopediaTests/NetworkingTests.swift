import Foundation
import Testing
@testable import CountriesEncyclopedia

private class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler no asignado")
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    override func stopLoading() {}
}

private struct TestRequest: RequestType {
    var path: String
    var method: HTTPMethod
    var body: [String: Any]?
    var queryItems: [URLQueryItem]?
}

private struct StubResponse: Codable, Equatable {
    let foo: String
}

struct NetworkingTests {
    private var provider: ConcreteNetworkingProvider {
        ConcreteNetworkingProvider(
            jsonDecoder: JSONDecoder(),
            requestBuilder: ConcreteRequestBuilder()
        )
    }

    @Test func testVoidSendSucceeds() async throws {
        // Preparo el mock para responder 200 y datos vacíos
        MockURLProtocol.requestHandler = { request in
            let resp = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (resp, Data())
        }
        // Registro el protocolo antes de la llamada
        URLProtocol.registerClass(MockURLProtocol.self)
        defer { URLProtocol.unregisterClass(MockURLProtocol.self) }

        // Debe completarse sin lanzar
        try await provider.sendRequest(
            endpoint: TestRequest(
                path: "/foo",
                method: .get,
                body: nil,
                queryItems: nil
            )
        )
        #expect(true)
    }

    @Test func testDecodableSendSucceeds() async throws {
        let stub = StubResponse(foo: "bar")
        let data = try JSONEncoder().encode(stub)
        MockURLProtocol.requestHandler = { request in
            let resp = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (resp, data)
        }
        URLProtocol.registerClass(MockURLProtocol.self)
        defer { URLProtocol.unregisterClass(MockURLProtocol.self) }

        let result: StubResponse = try await provider.sendRequest(
            endpoint: TestRequest(
                path: "/foo",
                method: .get,
                body: nil,
                queryItems: nil
            ),
            responseModel: StubResponse.self
        )
        #expect(result == stub)
    }
}
