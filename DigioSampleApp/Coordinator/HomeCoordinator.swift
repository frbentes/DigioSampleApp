
import UIKit

class HomeCoordinator: BaseCoordinator {
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController?
    var viewController: UIViewController!
    var childCoordinator: BaseCoordinator?
    var viewModel: HomeViewModel?
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
        viewModel = HomeViewModel()
        guard let viewModel = viewModel else { return }
        viewController = HomeViewController(viewModel: viewModel)
    }
    
    func closeHome() {
        self.didFinish(self)
    }
}
