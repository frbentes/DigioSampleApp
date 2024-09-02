
import UIKit

enum HomeUIConstants {
    
    enum Layouts {
        static let collectionFlowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
            
            return layout
        }()
    }
}
