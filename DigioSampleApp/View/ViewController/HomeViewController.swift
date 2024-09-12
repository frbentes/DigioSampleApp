
import UIKit

class HomeViewController: UIViewController {
    // MARK: - Views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var viewContent: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewError: ErrorView = {
        let view = ErrorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.delegate = self
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = UIColor(named: "gray-asphalt")
        indicator.isHidden = true
        return indicator
    }()
    
    private lazy var viewGreeting: HomeGreetingView = {
        let view = HomeGreetingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var collectionViewSpotlight: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(
            HomeSpotlightCell.self,
            forCellWithReuseIdentifier: HomeSpotlightCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var viewCash: HomeCashView = {
        let view = HomeCashView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var labelProducts: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "blue-brand")
        label.text = "Produtos"
        return label
    }()
    
    private lazy var collectionViewProduct: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(
            HomeProductCell.self,
            forCellWithReuseIdentifier: HomeProductCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Properties
    private let viewModel: HomeViewModel
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Initializer
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
        setupConstraints()
        
        viewModel.viewDelegate = self
        viewModel.getHomeData()
    }
    
    // MARK: - Functions
    private func configureUI() {
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        view.addSubview(viewError)
        viewContent.addSubview(viewGreeting)
        viewContent.addSubview(collectionViewSpotlight)
        viewContent.addSubview(viewCash)
        viewContent.addSubview(labelProducts)
        viewContent.addSubview(collectionViewProduct)
        scrollView.addSubview(viewContent)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            viewContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewContent.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            viewError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewError.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewError.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            viewGreeting.topAnchor.constraint(equalTo: viewContent.topAnchor, constant: 10),
            viewGreeting.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            viewGreeting.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            
            collectionViewSpotlight.topAnchor.constraint(equalTo: viewGreeting.bottomAnchor, constant: 8),
            collectionViewSpotlight.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            collectionViewSpotlight.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -4),
            collectionViewSpotlight.heightAnchor.constraint(equalToConstant: 176),
            
            viewCash.topAnchor.constraint(equalTo: collectionViewSpotlight.bottomAnchor, constant: 8),
            viewCash.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 16),
            viewCash.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            
            labelProducts.topAnchor.constraint(equalTo: viewCash.bottomAnchor, constant: 20),
            labelProducts.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 32),
            labelProducts.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            
            collectionViewProduct.topAnchor.constraint(equalTo: labelProducts.bottomAnchor, constant: 4),
            collectionViewProduct.leadingAnchor.constraint(equalTo: viewContent.leadingAnchor, constant: 24),
            collectionViewProduct.trailingAnchor.constraint(equalTo: viewContent.trailingAnchor, constant: -16),
            collectionViewProduct.bottomAnchor.constraint(equalTo: viewContent.bottomAnchor),
            collectionViewProduct.heightAnchor.constraint(equalToConstant: 136)
        ])
    }
    
    private func reloadViews() {
        DispatchQueue.main.async {
            self.collectionViewSpotlight.reloadData()
            self.viewCash.data = self.viewModel.getCashData()
            self.collectionViewProduct.reloadData()
        }
    }
    
    private func enableViews() {
        DispatchQueue.main.async {
            self.scrollView.isScrollEnabled = true
            self.viewContent.isHidden = false
        }
    }
    
    private func disableViews() {
        DispatchQueue.main.async {
            self.scrollView.isScrollEnabled = false
            self.viewContent.isHidden = true
        }
    }
    
    private func showErrorView(message: String) {
        DispatchQueue.main.async {
            self.viewError.setErrorMessage(message)
            self.viewError.isHidden = false
        }
    }
    
    private func hideErrorView() {
        viewError.isHidden = true
    }
    
    private func setActivityIndicatorHidden(_ hidden: Bool) {
        DispatchQueue.main.async {
            if hidden {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
            } else {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
            }
        }
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func startLoadingData() {
        disableViews()
        setActivityIndicatorHidden(false)
    }
    
    func finishLoadingData() {
        enableViews()
        setActivityIndicatorHidden(true)
    }
    
    func showHomeData(homeData: HomeData) {
        reloadViews()
    }
    
    func showGenericError(message: String) {
        reloadViews()
        disableViews()
        showErrorView(message: message)
    }
}

// MARK: - HomeCashViewDelegate
extension HomeViewController: HomeCashViewDelegate {
    func tapCashView() {
        let cashData = viewModel.getCashData()
        guard let cashData = cashData else {
            return
        }
        let productDetail = ProductDetail(
            title: cashData.title,
            imageURL: cashData.bannerURL,
            description: cashData.description,
            type: .cash)
        viewModel.showProductDetail(productDetail: productDetail)
    }
}

// MARK: - ErrorViewDelegate
extension HomeViewController: ErrorViewDelegate {
    func tapRetryButton() {
        hideErrorView()
        viewModel.getHomeData()
    }
}

// MARK: - CollectionView protocols
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewSpotlight {
            return viewModel.getSpotlightItems().count
        }
        return viewModel.getProducts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewSpotlight {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeSpotlightCell.identifier,
                for: indexPath
            ) as? HomeSpotlightCell else {
                return UICollectionViewCell()
            }
            let spotlightItems = viewModel.getSpotlightItems()
            cell.data = spotlightItems[indexPath.row]
            return cell
        } else if collectionView == collectionViewProduct {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: HomeProductCell.identifier,
                for: indexPath
            ) as? HomeProductCell else {
                return UICollectionViewCell()
            }
            let products = viewModel.getProducts()
            cell.data = products[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewSpotlight {
            let spotlightItems = viewModel.getSpotlightItems()
            let spotlight = spotlightItems[indexPath.row]
            let productDetail = ProductDetail(title: spotlight.name, imageURL: spotlight.bannerURL, description: spotlight.description, type: .spotlight)
            viewModel.showProductDetail(productDetail: productDetail)
        } else if collectionView == collectionViewProduct {
            let products = viewModel.getProducts()
            let product = products[indexPath.row]
            let productDetail = ProductDetail(title: product.name, imageURL: product.imageURL, description: product.description, type: .product)
            viewModel.showProductDetail(productDetail: productDetail)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewSpotlight {
            let width = UIScreen.main.bounds.size.width - 56.0
            return CGSize(width: width, height: 160)
        } else {
            return CGSize(width: 120, height: 120)
        }
    }
}
