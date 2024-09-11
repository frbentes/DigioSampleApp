
import UIKit
import Kingfisher

class HomeSpotlightCell: UICollectionViewCell {
    var data: Spotlight? {
        didSet {
            refreshUI()
        }
    }
    
    // MARK: - Properties
    public static let identifier = String(describing: HomeSpotlightCell.self)
    
    // MARK: - Views
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var imageViewSpotlight: UIImageView = {
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
        viewContainer.subviews.forEach { $0.removeFromSuperview() }
        data = nil
    }

    private func commonInit() {
        setupView()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        viewContainer.roundedCorners()
        contentView.shadowCorners()
    }
    
    private func setupView() {
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(imageViewSpotlight)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewContainer.heightAnchor.constraint(equalToConstant: 160),
            imageViewSpotlight.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            imageViewSpotlight.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            imageViewSpotlight.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            imageViewSpotlight.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor)
        ])
    }
    
    private func refreshUI() {
        guard let data = data, let bannerURL = data.bannerURL else {
            imageViewSpotlight.image = UIImage(named: "ic-placeholder-image")
            return
        }
        let url = URL(string: bannerURL)
        imageViewSpotlight.kf.setImage(with: url,
                                       placeholder: UIImage(named: "ic-placeholder-image"))
    }
}
