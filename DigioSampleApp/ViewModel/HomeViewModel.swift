
import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showHomeData(homeData: HomeData)
    func showGenericError()
}

protocol HomeViewModelCoordinatorDelegate: AnyObject {
    func openProductDetail(_ productDetail: ProductDetail)
}

final class HomeViewModel {
    private var homeData: HomeData?
    private var isLoadingHomeData: Bool = false
    
    public weak var delegate: HomeViewModelDelegate?
    public weak var coordinatorDelegate: HomeViewModelCoordinatorDelegate?
    
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
        Service().getProducts(completion: { [weak self] (homeData, error) in
            self?.isLoadingHomeData = false
            if error == nil {
                guard let homeData = homeData else {
                    self?.delegate?.showGenericError()
                    return
                }
                self?.delegate?.showHomeData(homeData: homeData)
            } else {
                self?.delegate?.showGenericError()
            }
        })
    }
    
    public func showProductDetail(productDetail: ProductDetail) {
        self.coordinatorDelegate?.openProductDetail(productDetail)
    }
}
