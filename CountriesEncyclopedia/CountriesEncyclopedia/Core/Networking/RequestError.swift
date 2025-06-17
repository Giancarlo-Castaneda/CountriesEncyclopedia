import Foundation

public enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
    case badRequest
}

// MARK: - LocalizedError

extension RequestError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .decode:
            return "Decode error"

        case .unauthorized:
            return "Session expired"

        case .invalidURL:
            return "Invalid URL"

        case .noResponse:
            return "No response"

        case .unknown:
            return "Unknown error"

        case .unexpectedStatusCode:
            return "Unexpected Status Code"

        case .badRequest:
            return "Bad request"
        }
    }
}
