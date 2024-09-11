
import UIKit

class HomeCoordinator: BaseCoordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController?
    var viewController: UIViewController!
    var childCoordinator: BaseCoordinator?
    var viewModel: HomeViewModel?
    var productDetailView: ProductDetailViewController!
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController?.isNavigationBarHidden = true
        viewModel = HomeViewModel()
        guard let viewModel = viewModel else { return }
        viewModel.coordinatorDelegate = self
        viewController = HomeViewController(viewModel: viewModel)
    }
    
    func closeHome() {
        self.didFinish(self)
    }
}

extension HomeCoordinator: HomeViewModelCoordinatorDelegate {
    func openProductDetail(_ productDetail: ProductDetail) {
        let viewModel = ProductDetailViewModel(model: productDetail)
        viewModel.coordinatorDelegate = self
        productDetailView = ProductDetailViewController(viewModel: viewModel)
        navigationController?.pushViewController(productDetailView, animated: true)
    }
}

extension HomeCoordinator: ProductDetailViewModelCoordinatorDelegate {
    func backHome() {
        navigationController?.popViewController(animated: true)
        productDetailView = nil
    }
}
