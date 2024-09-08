
import XCTest
@testable import DigioSampleApp

final class ProductDetailViewModelTest: XCTestCase {
    
    var sut: ProductDetailViewModel!
    var mockCoordinatorDelegate: ProductDetailViewModelCoordinatorDelegateMock!

    override func setUp() {
        super.setUp()
        mockCoordinatorDelegate = ProductDetailViewModelCoordinatorDelegateMock()
        let model = StubGenerator().stubProductDetail()
        sut = ProductDetailViewModel(model: model)
        sut.coordinatorDelegate = mockCoordinatorDelegate
    }

    override func tearDown() {
        sut = nil
        mockCoordinatorDelegate = nil
        super.tearDown()
    }
    
    func testGetProductDetail() {
        // When
        let productDetail = sut.getProductDetail()
        
        // Assert
        XCTAssertNotNil(productDetail)
    }
    
    func testBackToHome() {
        // When
        sut.returnHomeScreen()
        
        // Assert
        XCTAssert(mockCoordinatorDelegate.backHomeCalled)
    }
}

class ProductDetailViewModelCoordinatorDelegateMock: ProductDetailViewModelCoordinatorDelegate {
    var backHomeCalled: Bool = false
    
    func backHome() {
        backHomeCalled = true
    }
}
