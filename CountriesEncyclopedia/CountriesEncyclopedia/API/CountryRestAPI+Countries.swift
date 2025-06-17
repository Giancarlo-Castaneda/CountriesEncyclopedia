import Foundation

extension CountryRestAPI {

    static func countryListGET() -> CountryRestAPI {
        let query = [URLQueryItem(name: "fields", value: "name,flags,capital")]

        return .init(path: "all", method: .get, body: nil, queryItems: query)
    }
}
