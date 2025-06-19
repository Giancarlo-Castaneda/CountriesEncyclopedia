import Foundation

extension CountryRestAPI {

    static func countryListGET() -> CountryRestAPI {
        let query = [URLQueryItem(name: "fields", value: "name,flags,capital,region,subregion,currencies,population,languages,coatOfArms,timezones")]

        return .init(path: "/all", method: .get, body: nil, queryItems: query)
    }

    static func countryGET(by name: String) -> CountryRestAPI {
        .init(path: "/name/\(name)", method: .get, body: nil, queryItems: nil)
    }
}
