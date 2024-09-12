
import Foundation

protocol ProductDetailViewModelCoordinatorDelegate: AnyObject {
    func backHome()
}

final class ProductDetailViewModel {
    // MARK: - Variables
    private let productDetail: ProductDetail
    
    public weak var coordinatorDelegate: ProductDetailViewModelCoordinatorDelegate?
    
    // MARK: - Initializer
    init(model: ProductDetail) {
        productDetail = model
    }
    
    // MARK: - Functions
    public func getProductDetail() -> ProductDetail {
        return productDetail
    }
    
    public func returnHomeScreen() {
        self.coordinatorDelegate?.backHome()
    }
}
