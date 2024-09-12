
import Foundation

class JsonModelFactory {
    static func makeModel<T: Codable>(_: T.Type, fromJSON json: String) throws -> T {
        let bundle = Bundle(for: self)
        guard let filePath = bundle.url(forResource: json, withExtension: "json") else {
            throw NSError(domain: "InvalidFilePath", code: 404, userInfo: [NSLocalizedDescriptionKey: "File not found"])
        }
        let fileContent = try Data(contentsOf: filePath)
        return try JSONDecoder().decode(T.self, from: fileContent)
    }
}
