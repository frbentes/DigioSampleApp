
import Foundation

enum ServiceError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

protocol HomeServiceProtocol {
    func fetchProducts(completion: @escaping (HomeData?, ServiceError?) -> Void)
}

class HomeService: HomeServiceProtocol {
    func fetchProducts(completion: @escaping (HomeData?, ServiceError?) -> Void) {
        guard let url = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(nil, ServiceError.invalidData)
                    return
                }
                guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                    completion(nil, ServiceError.invalidResponse)
                    return
                }
                do {
                    let model = try JSONDecoder().decode(HomeData.self, from: data)
                    completion(model, nil)
                } catch {
                    completion(nil, ServiceError.message(error))
                }
            }
        }.resume()
    }
}
