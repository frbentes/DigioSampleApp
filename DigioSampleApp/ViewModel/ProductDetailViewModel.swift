
import Foundation

protocol ProductDetailViewModelCoordinatorDelegate: AnyObject {
    func backHome()
}

final class ProductDetailViewModel {
    private let productDetail: ProductDetail
    
    public weak var coordinatorDelegate: ProductDetailViewModelCoordinatorDelegate?
    
    init(model: ProductDetail) {
        productDetail = model
    }
    
    // MARK: - Public Gets
    public func getProductDetail() -> ProductDetail {
        return productDetail
    }
    
    public func returnHomeScreen() {
        self.coordinatorDelegate?.backHome()
    }
}
