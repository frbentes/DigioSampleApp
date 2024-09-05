
import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    // MARK: UI
    private lazy var buttonBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ic-arrow"), for: .normal)
        button.imageView?.transform = .init(rotationAngle: .pi)
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
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "black-charcoal")
        label.textAlignment = .left
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
        
        configureUI()
        setupConstraints()
        setupData()
        
        self.view.backgroundColor = .green
    }
    
    private func configureUI() {
        view.addSubview(buttonBack)
        view.addSubview(labelTitle)
        view.addSubview(imageViewProduct)
        view.addSubview(labelDescription)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonBack.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            buttonBack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonBack.heightAnchor.constraint(equalToConstant: 32),
            buttonBack.widthAnchor.constraint(equalToConstant: 32),
            labelTitle.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: 20),
            labelTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelTitle.centerYAnchor.constraint(equalTo: buttonBack.centerYAnchor),
            imageViewProduct.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 20),
            imageViewProduct.heightAnchor.constraint(equalToConstant: 80),
            imageViewProduct.widthAnchor.constraint(equalToConstant: 80),
            imageViewProduct.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelDescription.topAnchor.constraint(equalTo: imageViewProduct.bottomAnchor, constant: 16),
            labelDescription.leadingAnchor.constraint(equalTo: buttonBack.trailingAnchor, constant: 16),
            labelDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelDescription.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func setupData() {
        let productDetail = viewModel.getProductDetail()
        labelTitle.text = productDetail.title
        labelDescription.text = productDetail.description
        if let imageURL = productDetail.imageURL {
            let url = URL(string: imageURL)
            imageViewProduct.kf.setImage(with: url,
                                         placeholder: UIImage(named: "ic-photo"))
        } else {
            imageViewProduct.image = UIImage(named: "ic-photo")
        }
    }
}

@objc extension ProductDetailViewController {
    private func backButtonTapped(_ sender: UIButton) {
        viewModel.returnHomeScreen()
    }
}
