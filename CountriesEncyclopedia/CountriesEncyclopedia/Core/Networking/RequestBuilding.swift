import Foundation

protocol RequestBuilding {
    /// Crea un `URLRequest` a partir del endpoint.
    /// - Parameter overrideAuth: si no es nil, se usará *en vez* del access-token.
    func makeRequest(endpoint: RequestType) throws -> URLRequest
}

final class ConcreteRequestBuilder: RequestBuilding {

    // MARK: - Internal Methods

    func makeRequest(endpoint: RequestType) throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme     = endpoint.scheme
        urlComponents.host       = endpoint.host
        urlComponents.port       = endpoint.port
        urlComponents.path       = endpoint.version + endpoint.path
        urlComponents.queryItems = endpoint.queryItems

        guard
            let url = urlComponents.url
        else { throw RequestError.invalidURL }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers

        if let body = endpoint.body {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        }

        return request
    }
}
