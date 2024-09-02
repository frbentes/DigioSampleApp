
import UIKit

final class HomeGreetingView: UIView {
    
    // MARK: - UI
    private lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var imageViewHeader: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic-digio-logo")
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelNameHeader: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "black-charcoal")
        label.text = "Olá, Digio"
        label.textAlignment = .left
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
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        stackViewHeader.addArrangedSubview(imageViewHeader)
        stackViewHeader.addArrangedSubview(labelNameHeader)
        addSubview(stackViewHeader)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewHeader.topAnchor.constraint(equalTo: topAnchor),
            stackViewHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackViewHeader.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            imageViewHeader.widthAnchor.constraint(equalToConstant: 48),
            imageViewHeader.heightAnchor.constraint(equalToConstant: 48),
            labelNameHeader.centerYAnchor.constraint(equalTo: imageViewHeader.centerYAnchor)
        ])
    }
}
