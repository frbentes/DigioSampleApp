
import Foundation

struct ProductDetail {
    let title: String
    let imageURL: String?
    let description: String
    let type: ProductType
}

enum ProductType {
    case spotlight
    case cash
    case product
}
