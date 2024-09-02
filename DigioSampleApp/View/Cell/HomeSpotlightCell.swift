
import UIKit

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
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageViewSpotlight: UIImageView = {
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
        viewContainer.subviews.forEach { $0.removeFromSuperview() }
        data = nil
    }

    private func commonInit() {
        setupView()
        
        viewContainer.backgroundColor = .clear
        
        layer.shadowColor = UIColor(named: "gray-shadow")?.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = .init(width: 0, height: 1)
        layer.shadowRadius = 4
        clipsToBounds = false
    }
    
    private func setupView() {
        contentView.addSubview(viewContainer)
        viewContainer.addSubview(imageViewSpotlight)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: topAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageViewSpotlight.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor),
            imageViewSpotlight.centerYAnchor.constraint(equalTo: viewContainer.centerYAnchor)
        ])
    }
    
    private func refreshUI() {
        guard let data = data else { return }
        print(data)
    }
}
