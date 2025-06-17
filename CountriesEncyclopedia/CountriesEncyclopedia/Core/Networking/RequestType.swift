import Foundation

public protocol RequestType {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var body: [String: Any]? { get }
    var queryItems: [URLQueryItem]? { get }
    var port: Int? { get }
}

public extension RequestType {

    var scheme: String { "https" }

    var host: String { "restcountries.com/v3.1/" }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }

    var port: Int? { nil }
}
