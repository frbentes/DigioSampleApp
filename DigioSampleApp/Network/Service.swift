
import Foundation

enum ServiceError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

class Service {
    static let shared = Service()
    
    private init() {}
    
    func getProducts(by completion: @escaping (Result<HomeData, Error>) -> Void) {
        guard let url = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(error ?? ServiceError.invalidData))
                    return
                }
                guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                    completion(.failure(error ?? ServiceError.invalidResponse))
                    return
                }
                do {
                    let model = try JSONDecoder().decode(HomeData.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(ServiceError.message(error)))
                }
            }
        }.resume()
    }
}
