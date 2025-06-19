import Foundation

final class ConcreteNetworkingProvider: NetworkingProvider {

    // MARK: - Private Properties

    private let jsonDecoder: JSONDecoder
    private let requestBuilder: RequestBuilding

    // MARK: - Initialization

    init(jsonDecoder: JSONDecoder, requestBuilder: RequestBuilding = ConcreteRequestBuilder()) {
        self.jsonDecoder = jsonDecoder
        self.requestBuilder = requestBuilder
    }

    // MARK: - Private Methods

    private func launch(request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw RequestError.noResponse }

        NetLogger.response(httpResponse, data: data)

        switch httpResponse.statusCode {
        case 200...299:
            return data

        case 401:
            throw RequestError.unauthorized

        case 400:
            throw RequestError.badRequest

        default:
            throw RequestError.unexpectedStatusCode
        }
    }

    // MARK: - Internal Methods

    func sendRequest(endpoint: any RequestType) async throws {
        let request = try requestBuilder.makeRequest(endpoint: endpoint)
        NetLogger.request(request, body: endpoint.body)
        _ = try await launch(request: request)
    }

    func sendRequest<T: Decodable>(endpoint: any RequestType, responseModel: T.Type) async throws -> T {
        let request = try requestBuilder.makeRequest(endpoint: endpoint)
        NetLogger.request(request, body: endpoint.body)
        let data = try await launch(request: request)

        return try jsonDecoder.decode(T.self, from: data)
    }
}
