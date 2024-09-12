
import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func startLoadingData()
    func finishLoadingData()
    func showHomeData(homeData: HomeData)
    func showGenericError(message: String)
}

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func openProductDetail(_ productDetail: ProductDetail)
}

final class HomeViewModel {
    // MARK: - Variables
    private var homeData: HomeData?
    
    public weak var viewDelegate: HomeViewModelDelegate?
    public weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    private let service: HomeServiceProtocol
    
    // MARK: - Initializer
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    // MARK: - Functions
    public func getSpotlightItems() -> [Spotlight] {
        var spotlightItems: [Spotlight] = []
        guard let homeData = homeData else {
            return spotlightItems
        }
        spotlightItems = homeData.spotlight
        return spotlightItems
    }
    
    public func getCashData() -> Cash? {
        return homeData?.cash
    }
    
    public func getProducts() -> [Product] {
        var products: [Product] = []
        guard let homeData = homeData else {
            return products
        }
        products = homeData.products
        return products
    }
    
    public func getHomeData() {
        self.viewDelegate?.startLoadingData()
        service.fetchProducts(completion: { [weak self] (homeData, error) in
            guard let self = self else { return }
            self.homeData = homeData
            self.viewDelegate?.finishLoadingData()
            if let homeData = homeData {
                self.viewDelegate?.showHomeData(homeData: homeData)
            } else if let error = error {
                let message = self.messageFromError(error)
                self.viewDelegate?.showGenericError(message: message)
            } else {
                self.viewDelegate?.showGenericError(message: "Erro inesperado.")
            }
        })
    }
    
    private func messageFromError(_ error: ServiceError) -> String {
        let message: String
        switch error {
        case .invalidData:
            message = "Ocorreu um erro ao solicitar os dados."
        case .invalidResponse:
            message = "Resposta inválida."
        case .message(let err):
            message = err?.localizedDescription ?? "Sem mensagem de erro disponível."
        }
        return message
    }
    
    public func resetHomeData() {
        self.homeData = nil
    }
    
    public func showProductDetail(productDetail: ProductDetail) {
        self.coordinatorDelegate?.openProductDetail(productDetail)
    }
}
