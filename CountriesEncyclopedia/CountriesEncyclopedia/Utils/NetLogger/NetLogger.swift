import Foundation
import os

struct NetLogger {

    private static let log = Logger(subsystem: Bundle.main.bundleIdentifier ?? "CountriesEncyclopedia", category: "Networking")

    static func request(_ request: URLRequest, body: [String: Any]?, file: StaticString = #file, line: UInt = #line) {
#if DEBUG
        let url    = request.url?.absoluteString ?? "unknown url"
        let method = request.httpMethod ?? "–"
        log.debug("""
        📤 \(Date()) \(method, privacy: .public) \(url, privacy: .public)
        Headers: \(request.allHTTPHeaderFields ?? [:], privacy: .private)
        
        Body: \(body?.prettyJSON ?? "{}", privacy: .private)
        (file: \(file), line: \(line))
        """)
#endif
    }

    static func response(_ response: HTTPURLResponse, data: Data, file: StaticString = #file, line: UInt = #line) {
#if DEBUG
        let url  = response.url?.absoluteString ?? "unknown url"
        let code = response.statusCode
        log.debug("""
        ⬇️ \(Date()) [\(code)] \(url, privacy: .public)
        Body: \(data.prettyJSON, privacy: .private)
        (file: \(file), line: \(line))
        """)
#endif
    }
}
