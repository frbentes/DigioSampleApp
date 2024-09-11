
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
    private var homeData: HomeData?
    private var isLoadingHomeData: Bool = false
    
    public weak var viewDelegate: HomeViewModelDelegate?
    public weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
    private let service: HomeServiceProtocol
    
    init(service: HomeServiceProtocol = HomeService()) {
        self.service = service
    }
    
    // MARK: - Public Gets
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
        self.isLoadingHomeData = true
        self.viewDelegate?.startLoadingData()
        service.fetchProducts(completion: { [weak self] (homeData, error) in
            self?.isLoadingHomeData = false
            self?.homeData = homeData
            self?.viewDelegate?.finishLoadingData()
            if error == nil {
                guard let homeData = homeData else {
                    self?.viewDelegate?.showGenericError(message: "Dados inválidos.")
                    return
                }
                self?.viewDelegate?.showHomeData(homeData: homeData)
            } else {
                guard let error = error else {
                    self?.viewDelegate?.showGenericError(message: "Dados inválidos.")
                    return
                }
                let message: String
                switch error {
                case .invalidData:
                    message = "Dados inválidos."
                case .invalidResponse:
                    message = "Resposta inválida."
                case .message(let err):
                    message = err?.localizedDescription ?? "Sem mensagem de erro disponível."
                }
                self?.viewDelegate?.showGenericError(message: message)
            }
        })
    }
    
    public func showProductDetail(productDetail: ProductDetail) {
        self.coordinatorDelegate?.openProductDetail(productDetail)
    }
}
