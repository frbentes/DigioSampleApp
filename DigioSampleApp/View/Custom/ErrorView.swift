
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func tapRetryButton()
}

final class ErrorView: UIView {
    private lazy var stackViewContent: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var labelError: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(named: "black-charcoal")
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var viewContainerButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonRetry: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(named: "blue-brand")
        button.layer.cornerRadius = 20
        button.setTitle("Tentar novamente", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        return button
    }()
    
    public weak var delegate: ErrorViewDelegate?
    
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
        stackViewContent.addArrangedSubview(labelError)
        viewContainerButton.addSubview(buttonRetry)
        stackViewContent.addArrangedSubview(viewContainerButton)
        addSubview(stackViewContent)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewContent.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackViewContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackViewContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackViewContent.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            buttonRetry.heightAnchor.constraint(equalToConstant: 44),
            buttonRetry.topAnchor.constraint(equalTo: viewContainerButton.topAnchor),
            buttonRetry.bottomAnchor.constraint(equalTo: viewContainerButton.bottomAnchor),
            buttonRetry.centerXAnchor.constraint(equalTo: viewContainerButton.centerXAnchor)
        ])
    }
    
    func setErrorMessage(_ message: String) {
        labelError.text = message
    }
}

extension ErrorView {
    @objc func didTapRetry() {
        delegate?.tapRetryButton()
    }
}
