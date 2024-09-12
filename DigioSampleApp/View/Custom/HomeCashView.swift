
import UIKit
import Kingfisher

protocol HomeCashViewDelegate: AnyObject {
    func tapCashView()
}

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
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var labelCaption: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "blue-brand")
        return label
    }()
    
    private lazy var labelCash: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(named: "gray-asphalt")
        return label
    }()
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageViewCash: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCashView))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    public weak var delegate: HomeCashViewDelegate?
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        viewContainer.roundedCorners()
        viewContainer.shadowCorners()
    }
    
    private func configure() {
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        stackViewHeader.addArrangedSubview(labelCaption)
        stackViewHeader.addArrangedSubview(labelCash)
        addSubview(stackViewHeader)
        viewContainer.addSubview(imageViewCash)
        addSubview(viewContainer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackViewHeader.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackViewHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            viewContainer.topAnchor.constraint(equalTo: stackViewHeader.bottomAnchor, constant: 8),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            viewContainer.heightAnchor.constraint(equalToConstant: 96),
            
            imageViewCash.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            imageViewCash.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            imageViewCash.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            imageViewCash.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor)
        ])
    }
    
    private func refreshUI() {
        guard let data = data else {
            labelCaption.text = "digio"
            labelCash.text = "Cash"
            imageViewCash.image = UIImage(named: "ic-placeholder-image")
            return
        }
        let line = data.title.split(separator: " ", maxSplits: 1)
        labelCaption.text = String(line[0])
        labelCash.text = String(line[1])
        if let bannerURL = data.bannerURL {
            let url = URL(string: bannerURL)
            imageViewCash.kf.setImage(
                with: url,
                placeholder: UIImage(named: "ic-placeholder-image"))
        } else {
            imageViewCash.image = UIImage(named: "ic-placeholder-image")
        }
    }
}

extension HomeCashView {
    @objc func didTapCashView() {
        delegate?.tapCashView()
    }
}
