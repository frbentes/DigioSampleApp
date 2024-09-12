
import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    // MARK: UI
    private lazy var buttonBack: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic-arrow"), for: .normal)
        button.imageView?.transform = .init(rotationAngle: .pi)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "black-charcoal")
        label.textAlignment = .center
        return label
    }()
    
    private lazy var imageViewProduct: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "black-charcoal")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Properties
    private let viewModel: ProductDetailViewModel
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        setupImageType()
    }
    
    override func viewDidLayoutSubviews() {
        setupData()
    }
    
    private func configureUI() {
        view.addSubview(buttonBack)
        view.addSubview(labelTitle)
        view.addSubview(imageViewProduct)
        view.addSubview(labelDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            buttonBack.heightAnchor.constraint(equalToConstant: 40),
            buttonBack.widthAnchor.constraint(equalToConstant: 40),
            labelTitle.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor),
            labelTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewProduct.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 24),
            labelDescription.topAnchor.constraint(equalTo: imageViewProduct.bottomAnchor, constant: 20),
            labelDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupData() {
        let productDetail = viewModel.getProductDetail()
        labelTitle.text = productDetail.title
        if let imageURL = productDetail.imageURL {
            let url = URL(string: imageURL)
            imageViewProduct.kf.setImage(with: url,
                                         placeholder: UIImage(named: "ic-placeholder-image"))
        } else {
            imageViewProduct.image = UIImage(named: "ic-placeholder-image")
        }
        labelDescription.text = productDetail.description
        labelDescription.sizeToFit()
    }
    
    private func setupImageType() {
        let productDetail = viewModel.getProductDetail()
        switch productDetail.type {
        case .spotlight:
            imageViewProduct.heightAnchor.constraint(equalToConstant: 160).isActive = true
            imageViewProduct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
            imageViewProduct.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        case .cash:
            imageViewProduct.heightAnchor.constraint(equalToConstant: 96).isActive = true
            imageViewProduct.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
            imageViewProduct.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        case .product:
            imageViewProduct.heightAnchor.constraint(equalToConstant: 70).isActive = true
            imageViewProduct.widthAnchor.constraint(equalToConstant: 70).isActive = true
            imageViewProduct.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
}

@objc extension ProductDetailViewController {
    private func backButtonTapped(_ sender: UIButton) {
        viewModel.returnHomeScreen()
    }
}
