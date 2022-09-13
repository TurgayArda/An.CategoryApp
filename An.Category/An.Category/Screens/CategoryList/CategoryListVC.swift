//
//  CategoryListVC.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import UIKit
import SnapKit
import Alamofire

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
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initDelegate()
        fetchService()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
//        movieListViewModel?.delegate = self
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
    
    private func fetchService() {
        let headers: HTTPHeaders = [  "Api-Key": "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=",
                                      "Alias-Key": "AtS1aPFxlIdVLth6ee2SEETlRxk=",
                                      "Accept-Language": "en-US,en;q=0.5"
        ]
        
        AF.request("https://api.shopiroller.com/v2.0/categories", method: .get, headers: headers).responseDecodable(of: CategoryListResult.self) { categoryItem in
            guard let data = categoryItem.value else {
                return print("hata")
            }
            guard let categoryItemTwo = data.data else { return }
            self.categoryItem = categoryItemTwo
            self.categoryCollectionProvider.loadCategoryList(item: self.categoryItem)
            DispatchQueue.main.async {
                self.categoryListCollectionView.reloadData()
                self.title = "Categories"
            }
        }
        
    }
}

//MARK: - CategoryListProviderDelegate

extension CategoryListVC: CategoryListProviderDelegate {
    func selected(at select: Any) {
        print(select)
    }
    
    func getWidth() -> CGFloat {
        return view.frame.size.width
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
