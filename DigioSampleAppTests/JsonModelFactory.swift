
import Foundation

class JsonModelFactory {
    static func makeModel<T: Codable>(_: T.Type, fromJSON json: String) throws -> T {
        let bundle = Bundle(for: self)
        let filePath = bundle.url(forResource: json, withExtension: "json")
        let fileContent = try Data(contentsOf: filePath!)
        return try JSONDecoder().decode(T.self, from: fileContent)
    }
}
