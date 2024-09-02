
import UIKit

class HomeCashView: UIView {
    var data: Cash? {
        didSet {
            refreshUI()
        }
    }
    
    // MARK: - Views
    private lazy var stackViewHeader: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var labelCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "blue-brand")
        label.text = "digio"
        return label
    }()
    
    private lazy var labelCash: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(named: "gray-asphalt")
        label.text = "Cash"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cashImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupView()
    }
    
    private func setupView() {
        addSubview(stackViewHeader)
        stackViewHeader.addArrangedSubview(labelCaption)
        stackViewHeader.addArrangedSubview(labelCash)
        addSubview(containerView)
        containerView.addSubview(cashImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewHeader.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackViewHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackViewHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            containerView.topAnchor.constraint(equalTo: stackViewHeader.bottomAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: stackViewHeader.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func refreshUI() {
        guard let data = data else { return }
        print(data)
    }
}
