
import UIKit

public protocol CoordinatorDelegate: AnyObject {
    func didFinish(_ coordinator: BaseCoordinator)
}

extension CoordinatorDelegate {
    public func didFinish(_ coordinator: BaseCoordinator) {}
}

public protocol BaseCoordinator: CoordinatorDelegate {
    var delegate: CoordinatorDelegate? { get set }
    var navigationController: UINavigationController? { get set }
    var viewController: UIViewController! { get set }
    var childCoordinator: BaseCoordinator? { get set }
    
    func start()
    func stop()
}

extension BaseCoordinator {
    public func start() {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    public func stop() {
        delegate = nil
        navigationController = nil
        viewController = nil
        childCoordinator = nil
    }
    
    public func didFinish(_ coordinator: BaseCoordinator) {
        coordinator.stop()
    }
}
