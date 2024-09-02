
import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func showHomeData(homeData: HomeData)
    func showGenericError()
}

final class HomeViewModel {
    public weak var delegate: HomeViewModelDelegate?
    
    public func getHomeData() {
        Service().getProducts(completion: { [weak self] (homeData, error) in
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
}
