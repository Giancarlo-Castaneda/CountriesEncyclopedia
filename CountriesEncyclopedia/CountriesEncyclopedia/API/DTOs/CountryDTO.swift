import Foundation

// MARK: - CountryDTO

struct CountryDTO: Codable {
    let flags: Flag
    let name: CountryName
    let capital: [String]
}

// MARK: - Flags

struct Flag: Codable {
    let png: String
    let alt: String
}

// MARK: - Name

struct CountryName: Codable {
    let common: String
    let official: String
}
