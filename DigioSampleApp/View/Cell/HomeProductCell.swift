
import UIKit
import Kingfisher

class HomeProductCell: UICollectionViewCell {
    var data: Product? {
        didSet {
            refreshUI()
        }
    }
    
    // MARK: - Properties
    public static let identifier = String(describing: HomeProductCell.self)
    
    // MARK: - Views
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var imageViewProduct: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        data = nil
    }

    private func commonInit() {
        setupView()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        viewContainer.roundedCorners(radius: 20)
        contentView.shadowCorners()
    }
    
    private func setupView() {
        viewContainer.addSubview(imageViewProduct)
        contentView.addSubview(viewContainer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageViewProduct.heightAnchor.constraint(equalToConstant: 60),
            imageViewProduct.widthAnchor.constraint(equalToConstant: 60),
            imageViewProduct.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor),
            imageViewProduct.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor)
        ])
    }
    
    private func refreshUI() {
        guard let data = data, let imageURL = data.imageURL else {
            imageViewProduct.image = UIImage(named: "ic-placeholder-image")
            return
        }
        let url = URL(string: imageURL)
        imageViewProduct.kf.setImage(with: url,
                                     placeholder: UIImage(named: "ic-placeholder-image"))
    }
}
