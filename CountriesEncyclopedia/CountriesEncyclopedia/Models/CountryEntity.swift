import Foundation

struct CountryEntity: Identifiable, Hashable {

    // MARK: - Computed Properties

    var id: String {
        countryDTO.name.official
    }

    var name: String {
        countryDTO.name.common
    }

    var officialName: String {
        countryDTO.name.official
    }

    var flagURL: URL? {
        URL(string: countryDTO.flags.png ?? "")
    }

    var flagAltText: String {
        countryDTO.flags.alt ?? ""
    }

    var capital: String {
        countryDTO.capital?.compactMap{ $0 }.joined(separator: ", ") ?? ""
    }

    var formattedTimezones: String {
        countryDTO.timezones?.compactMap{ $0 }.joined(separator: "\n") ?? ""
    }

    var coatAtArms: URL? {
        URL(string: countryDTO.coatOfArms?.png ?? "")
    }

    var region: String {
        countryDTO.region ?? ""
    }

    var subregion: String {
        countryDTO.subregion ?? ""
    }

    var population: Int {
        countryDTO.population ?? 0
    }

    var languages: String {
        countryDTO.languages?.compactMap { $0.value }.joined(separator: "\n") ?? ""
    }

    var currenciesText: String {
        countryDTO.currencies?.compactMap { "\($0.key)  (\($0.value.symbol ?? "") \($0.value.name ?? ""))" }.joined(separator: ", ") ?? ""
    }

    var isLeftSide: Bool {
        countryDTO.car?.side == "left"
    }

    var isFavorite = false

    // MARK: - Private Properties

    private let countryDTO: CountryDTO

    // MARK: - Initialization

    init(_ dto: CountryDTO) {
        self.countryDTO = dto
    }
}

// MARK: - CountryRowData

extension CountryEntity: CountryRowData { }

// MARK: - Mock Data

extension CountryEntity {
    static let mock: CountryEntity = .init(.mock)
}
