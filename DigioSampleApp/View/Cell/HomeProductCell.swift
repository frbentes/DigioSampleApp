
import UIKit

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
        
    }
    
    private func refreshUI() {
        guard let data = data else { return }
        print(data)
    }
}
