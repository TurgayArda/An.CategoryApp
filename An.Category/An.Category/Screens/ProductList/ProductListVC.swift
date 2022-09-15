//
//  ProductListVC.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import UIKit
import SnapKit

class ProductListVC: UIViewController {
    
    //MARK: - Views
    
    private lazy var productListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(
            ProductListCollectionViewCell.self,
            forCellWithReuseIdentifier: ProductListCollectionViewCell.Identifier.path.rawValue
        )
        return collectionView
    }()
    
    //MARK: - Properties
    
    private var productItem: [ProductList] = []
    private var productCollectionProvider = ProductListProvider()
    
    var productListViewModel: ProductListViewModelProtocol?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        productListViewModel?.loadProductList(filter: "")
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        productListViewModel?.delegate = self
        productCollectionProvider.delegate = self
        productListCollectionView.delegate = productCollectionProvider
        productListCollectionView.dataSource = productCollectionProvider
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
        view.addSubview(productListCollectionView)
        
        configureConstraints()
        configureNavitaionBar()
    }
    
    private func configureConstraints() {
        makeCollection()
    }
    
    private func configureNavitaionBar() {
        let rightButton = UIBarButtonItem(title: "", style: .plain , target: self, action: #selector(fetchFilterItem(_:)))
        let imageConfiguration = UIImage.SymbolConfiguration(scale: .large)
        let buttonIcon = UIImage(systemName: "camera.filters", withConfiguration: imageConfiguration)
        rightButton.image = buttonIcon
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func fetchFilterItem(_ navigationItem: UIBarButtonItem) {
        let viewController = FilterVC()
        viewController.delegate = self
        viewController.modalPresentationStyle = .formSheet
        if let sheets = viewController.sheetPresentationController  {
            sheets.detents = [.medium(), .medium()]
        }
        self.present(viewController, animated: true, completion: nil)
    }
}

//MARK: - RouterFilterDelegate

extension ProductListVC: RouterFilterDelegate {
    func selectedFilterItem(select: String) {
        productListViewModel?.loadProductList(filter: select)
    }
}

//MARK: - ProductListProviderDelegate

extension ProductListVC: ProductListProviderDelegate {
    func selected(at select: String) {
        let viewController = ProductDetailBuilder.make(id: select)
        viewController.modalPresentationStyle = .fullScreen
        self.show(viewController, sender: nil)
    }
}

//MARK: - ProductListViewModelDelegate

extension ProductListVC: ProductListViewModelDelegate {
    func handleOutPut(_ output: ProductListViewModelOutPut) {
        switch output {
        case .showProductList(let productItem):
            self.productItem = productItem
            productCollectionProvider.loadProductList(item: productItem)
            DispatchQueue.main.async {
                self.productListCollectionView.reloadData()
            }
        case .showError(let error):
            print(error)
        case .title(let title):
            self.title = title
        }
    }
}

//MARK: - Constraints

extension ProductListVC {
    private func makeCollection() {
        productListCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }
    }
}
