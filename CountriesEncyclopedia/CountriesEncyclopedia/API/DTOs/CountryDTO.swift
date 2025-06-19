import Foundation

// MARK: - CountryDTO

struct CountryDTO: Codable, Hashable {
    let flags: Flag
    let name: CountryName
    let capital: [String]?
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let currencies: [String: Currency]?
    let population: Int?
    let car: CarDriverSide?
    let coatOfArms: Flag?
    let timezones: [String]?
}

struct CarDriverSide: Codable, Hashable {
    let signs: [String]?
    let side: String?

    static let empty: Self = .init(signs: [], side: "")
}

struct Currency: Codable, Hashable {
    let name: String?
    let symbol: String?
}

// MARK: - Flags

struct Flag: Codable, Hashable {
    let png: String?
    let alt: String?
}

// MARK: - Name

struct CountryName: Codable, Hashable {
    let common: String
    let official: String
}

extension CountryDTO {
    static let mock: Self = .init(flags: .init(png: nil, alt: nil),
                                  name: .init(common: "foo.common", official: "foo.official"),
                                  capital: ["foo.capital.1", "foo.capital.2"],
                                  region: "foo.region",
                                  subregion: "foo.subregion",
                                  languages: nil,
                                  currencies: nil,
                                  population: 111,
                                  car: .init(signs: [], side: nil),
                                  coatOfArms: .init(png: nil, alt: nil),
                                  timezones: nil)
}
