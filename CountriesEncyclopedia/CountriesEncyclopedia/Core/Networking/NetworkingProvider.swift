import Foundation

public protocol NetworkingProvider {

    func sendRequest(endpoint: RequestType) async throws
    func sendRequest<T: Decodable>(endpoint: RequestType, responseModel: T.Type) async throws -> T
}
