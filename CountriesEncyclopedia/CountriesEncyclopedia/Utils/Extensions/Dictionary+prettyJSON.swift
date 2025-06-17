import Foundation

extension Dictionary where Key == String, Value == Any {

    var prettyJSON: String {
        guard
            let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
        else { return "" }

        return data.prettyJSON
    }
}
