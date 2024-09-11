
import XCTest
@testable import DigioSampleApp

final class HomeViewModelTest: XCTestCase {
    
    var sut: HomeViewModel!
    var mockHomeService: MockHomeService!
    var mockViewDelegate: HomeViewModelDelegateMock!
    var mockCoordinatorDelegate: HomeViewModelCoordinatorDelegateMock!
    
    override func setUp() {
        super.setUp()
        mockHomeService = MockHomeService()
        mockViewDelegate = HomeViewModelDelegateMock()
        mockCoordinatorDelegate = HomeViewModelCoordinatorDelegateMock()
        
        sut = HomeViewModel(service: mockHomeService)
        sut.viewDelegate = mockViewDelegate
        sut.coordinatorDelegate = mockCoordinatorDelegate
    }
    
    override func tearDown() {
        sut = nil
        mockHomeService = nil
        mockViewDelegate = nil
        mockCoordinatorDelegate = nil
        super.tearDown()
    }
    
    func testGetHomeDataSuccess() {
        // Given
        let homeData = StubGenerator().stubHomeData()
        mockHomeService.completeHomeData = homeData
        
        // When
        sut.getHomeData()
        
        // Assert
        XCTAssert(mockViewDelegate.startLoadingCalled)
        
        mockHomeService.fetchSuccess()
        
        // Assert
        XCTAssert(mockViewDelegate.finishLoadingCalled)
        XCTAssert(mockViewDelegate.showHomeDataCalled)
    }
    
    func testGetHomeDataFailed() {
        // Given
        let error = ServiceError.invalidResponse
        
        // When
        sut.getHomeData()
        
        // Assert
        XCTAssert(mockViewDelegate.startLoadingCalled)
        
        mockHomeService.fetchFail(error: error)
        
        // Assert
        XCTAssert(mockViewDelegate.finishLoadingCalled)
        XCTAssert(mockViewDelegate.showGenericErrorCalled)
    }
    
    func testOpenProductDetail() {
        // Given
        let productDetail = StubGenerator().stubProductDetail()
        
        // When
        sut.showProductDetail(productDetail: productDetail)
        
        // Assert
        XCTAssert(mockCoordinatorDelegate.showProductDetailCalled)
    }
}

class MockHomeService: HomeServiceProtocol {
    var isFetchProductsCalled = false
    var completeHomeData: HomeData?
    var completeClosure: ((HomeData?, ServiceError?) -> Void)!
    
    func fetchProducts(completion: @escaping (DigioSampleApp.HomeData?, DigioSampleApp.ServiceError?) -> Void) {
        isFetchProductsCalled = true
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure(completeHomeData, nil)
    }
    
    func fetchFail(error: DigioSampleApp.ServiceError?) {
        completeClosure(nil, error)
    }
}

class HomeViewModelDelegateMock: HomeViewModelDelegate {
    var startLoadingCalled: Bool = false
    var finishLoadingCalled: Bool = false
    var showHomeDataCalled: Bool = false
    var showGenericErrorCalled: Bool = false
    
    func startLoadingData() {
        startLoadingCalled = true
    }
    
    func finishLoadingData() {
        finishLoadingCalled = true
    }
    
    func showHomeData(homeData: DigioSampleApp.HomeData) {
        showHomeDataCalled = true
    }
    
    func showGenericError(message: String) {
        showGenericErrorCalled = true
    }
}

class HomeViewModelCoordinatorDelegateMock: HomeViewModelCoordinatorDelegate {
    var showProductDetailCalled: Bool = false
    
    func openProductDetail(_ productDetail: DigioSampleApp.ProductDetail) {
        showProductDetailCalled = true
    }
}

class StubGenerator {
    func stubHomeData() -> HomeData {
        do {
            let homeData = try JsonModelFactory.makeModel(HomeData.self, fromJSON: "products_list")
            return homeData
        } catch {
            print("parse error")
        }
        return HomeData(spotlight: [],
                        products: [],
                        cash: Cash(title: "teste", bannerURL: nil, description: "teste"))
    }
    
    func stubProductDetail() -> ProductDetail {
        return ProductDetail(title: "digio Cash",
                             imageURL: "https://s3-sa-east-1.amazonaws.com/digio-exame/cash_banner.png",
                             description: "Dinheiro na conta sem complicaÃ§Ã£o.",
                             type: .cash)
    }
}
