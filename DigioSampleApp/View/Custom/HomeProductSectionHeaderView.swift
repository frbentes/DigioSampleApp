
import UIKit

class HomeProductSectionHeaderView: UICollectionReusableView {
    // MARK: - Constants
    static let height: CGFloat = 50
    static let identifier = String(describing: HomeProductSectionHeaderView.self)
    
    // MARK: - UI
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "blue-brand")
        label.text = "Produtos"
        return label
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        addSubview(labelTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            labelTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
