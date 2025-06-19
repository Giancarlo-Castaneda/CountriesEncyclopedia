import Foundation
import SwiftData

@Model
final class FavoriteCountry {

    @Attribute(.unique) var commonName: String
    @Attribute(.unique) var officialName: String
    var capital: String
    var flagUrl: URL?
    
    init(commonName: String, officialName: String, capital: String, flagUrl: URL? = nil) {
        self.commonName = commonName
        self.officialName = officialName
        self.capital = capital
        self.flagUrl = flagUrl
    }
}
