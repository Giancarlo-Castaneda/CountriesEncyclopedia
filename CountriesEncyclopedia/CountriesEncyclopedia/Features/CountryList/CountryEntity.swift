import Foundation

struct CountryEntity: Identifiable {

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
        countryDTO.capital.first ?? ""
    }

    var formattedTimezones: String {
        countryDTO.timezones?.compactMap{ $0 }.joined(separator: "\n") ?? ""
    }

    // MARK: - Private Properties

    private let countryDTO: CountryDTO

    // MARK: - Initialization

    init(_ dto: CountryDTO) {
        self.countryDTO = dto
    }
}
