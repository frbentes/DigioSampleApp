
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
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    private func setupView() {
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            productImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func refreshUI() {
        guard let data = data, let imageURL = data.imageURL else {
            productImageView.image = UIImage(named: "ic-photo")
            return
        }
        let url = URL(string: imageURL)
        productImageView.kf.setImage(with: url,
                                     placeholder: UIImage(named: "ic-photo"))
    }
}
