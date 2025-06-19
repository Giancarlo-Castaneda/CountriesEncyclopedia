import Foundation
import SwiftData

@Model
final class FavoriteCountry {

    @Attribute(.unique) var name: String
    @Attribute(.unique) var officialName: String
    var capital: String
    var flagURL: URL?
    var flagAltText: String

    init(commonName: String, officialName: String, capital: String, flagUrl: URL? = nil, flagAltText: String) {
        self.name = commonName
        self.officialName = officialName
        self.capital = capital
        self.flagURL = flagUrl
        self.flagAltText = flagAltText
    }
}

extension FavoriteCountry: CountryRowData {

    var isFavorite: Bool {
        true
    }
}
