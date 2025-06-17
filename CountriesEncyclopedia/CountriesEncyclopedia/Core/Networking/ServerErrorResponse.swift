import Foundation

struct ServerErrorResponse: Decodable {

    let status: Int
    let message: String
}
