import Foundation

struct CountryRestAPI: RequestType {

    // MARK: - Private Properties

    let path: String
    let method: HTTPMethod
    let body: [String: Any]?
    let queryItems: [URLQueryItem]?

    // MARK: - Initialization

    init(path: String, method: HTTPMethod, body: [String: Any]?, queryItems: [URLQueryItem]?) {
        self.path = path
        self.method = method
        self.body = body
        self.queryItems = queryItems
    }
}
