import Foundation

// MARK: - CountryDTO

struct CountryDTO: Codable {
    let flags: Flag
    let name: CountryName
    let capital: [String]
    let region: String?
    let subregion: String?
    let languages: [String: String]?
    let currencies: [String: Currency]?
    let population: Int?
    let car: CarDriverSide?
    let coatOfArms: Flag?
    let area: Double?
    let timezones: [String]?
}

struct CarDriverSide: Codable {
    let signs: [String]?
    let side: String?

    var isLeftSide: Bool {
        side == "left"
    }

    static let empty: Self = .init(signs: [], side: "")
}

struct Currency: Codable {
    let name: String?
    let symbol: String?
}

// MARK: - Flags

struct Flag: Codable {
    let png: String?
    let alt: String?
}

// MARK: - Name

struct CountryName: Codable {
    let common: String
    let official: String
}
