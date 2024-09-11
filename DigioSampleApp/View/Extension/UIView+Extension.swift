
import UIKit

extension UIView {
    func shadowCorners() {
        layer.shadowColor = UIColor(named: "gray-shadow")?.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.shadowRadius = 4
    }
    
    func roundedCorners(radius: CGFloat = 10) {
        layer.cornerRadius = radius
    }
}
