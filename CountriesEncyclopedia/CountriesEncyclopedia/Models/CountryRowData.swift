import Foundation

protocol CountryRowData {

    var name: String { get }
    var officialName: String { get }
    var capital: String { get }
    var flagURL: URL? { get }
    var flagAltText: String { get }
    var isFavorite: Bool { get }
}
