//
//  CategoryListVC.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import UIKit
import SnapKit

class CategoryListVC: UIViewController {
    
    //MARK: - Views
    
    private lazy var categoryListCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray6
        collectionView.register(
            CategoryListCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryListCollectionViewCell.Identifier.path.rawValue
        )
        return collectionView
    }()
    
    //MARK: - Properties
    
    private var categoryItem: [CategoryList] = []
    private var categoryCollectionProvider = CategoryListProvider()
    
    var categoryListViewModel: CategoryListViewModelProtocol?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        categoryListViewModel?.load()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        categoryListViewModel?.delegate = self
        categoryCollectionProvider.delegate = self
        categoryListCollectionView.delegate = categoryCollectionProvider
        categoryListCollectionView.dataSource = categoryCollectionProvider
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemGray6
        view.addSubview(categoryListCollectionView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        makeCollection()
    }
}

//MARK: - CategoryListViewModelDelegate

extension CategoryListVC: CategoryListViewModelDelegate {
    func handleOutPut(_ output: CategoryListViewModelOutPut) {
        switch output {
        case .showCategoryList(let item):
            self.categoryItem = item
            categoryCollectionProvider.loadCategoryList(item: item)
            DispatchQueue.main.async {
                self.categoryListCollectionView.reloadData()
            }
        case .showError(let error):
            print(error)
        case .title(let title):
            self.title = title
        }
    }
}

//MARK: - CategoryListProviderDelegate

extension CategoryListVC: CategoryListProviderDelegate {
    func selected(at select: String) {
        let viewController = ProductListBuilder.make(id: select)
        viewController.modalPresentationStyle = .fullScreen
        self.show(viewController, sender: nil)
    }
}

//MARK: - Constraints

extension CategoryListVC {
    private func makeCollection() {
        categoryListCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }
    }
}
