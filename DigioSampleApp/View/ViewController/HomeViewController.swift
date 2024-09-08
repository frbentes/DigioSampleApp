
import UIKit

class HomeViewController: UIViewController {
    
    // MARK: TYPEALIAS
    private typealias Layouts = HomeUIConstants.Layouts
    
    // MARK: - UI
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var greetingView: HomeGreetingView = {
        let view = HomeGreetingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var spotlightCollectionView: UICollectionView = {
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: Layouts.collectionFlowLayout)
        collectionView.register(HomeSpotlightCell.self, forCellWithReuseIdentifier: HomeSpotlightCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = false
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private lazy var cashView: HomeCashView = {
        let view = HomeCashView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame,
                                              collectionViewLayout: Layouts.collectionFlowLayout)
        collectionView.register(HomeProductCell.self, forCellWithReuseIdentifier: HomeProductCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = false
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    // MARK: - Properties
    private let viewModel: HomeViewModel
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setupConstraints()
        
        viewModel.viewDelegate = self
        viewModel.getHomeData()
    }
    
    private func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(greetingView)
        contentView.addSubview(spotlightCollectionView)
        contentView.addSubview(cashView)
        contentView.addSubview(productCollectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            greetingView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            greetingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            greetingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            spotlightCollectionView.topAnchor.constraint(equalTo: greetingView.bottomAnchor, constant: 16),
            spotlightCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            spotlightCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            cashView.topAnchor.constraint(equalTo: spotlightCollectionView.bottomAnchor, constant: 16),
            cashView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cashView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            cashView.heightAnchor.constraint(equalToConstant: 45),
            
            productCollectionView.topAnchor.constraint(equalTo: cashView.bottomAnchor, constant: 16),
            productCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    private func updateData() {
        DispatchQueue.main.async {
            self.spotlightCollectionView.reloadData()
            self.cashView.data = self.viewModel.getCashData()
            self.productCollectionView.reloadData()
        }
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showHomeData(homeData: HomeData) {
        updateData()
    }
    
    func showGenericError() {
        updateData()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == spotlightCollectionView {
            return viewModel.getSpotlightItems().count
        }
        return viewModel.getProducts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == spotlightCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeSpotlightCell.identifier,
                for: indexPath
            ) as? HomeSpotlightCell
            else {
                return UICollectionViewCell()
            }
            let spotlightItems = viewModel.getSpotlightItems()
            cell.data = spotlightItems[indexPath.row]
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeProductCell.identifier,
            for: indexPath
        ) as? HomeProductCell
        else {
            return UICollectionViewCell()
        }
        let products = viewModel.getProducts()
        cell.data = products[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == spotlightCollectionView {
            let spotlightItems = viewModel.getSpotlightItems()
            let spotlight = spotlightItems[indexPath.row]
            let productDetail = ProductDetail(title: spotlight.name, imageURL: spotlight.bannerURL, description: spotlight.description)
            viewModel.showProductDetail(productDetail: productDetail)
        } else if collectionView == productCollectionView {
            let products = viewModel.getProducts()
            let product = products[indexPath.row]
            let productDetail = ProductDetail(title: product.name, imageURL: product.imageURL, description: product.description)
            viewModel.showProductDetail(productDetail: productDetail)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == spotlightCollectionView {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: 0, height: 0)
    }
}
