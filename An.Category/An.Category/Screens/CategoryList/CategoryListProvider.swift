//
//  CategoryListProvider.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import UIKit

class CategoryListProvider: NSObject {
    var delegate: CategoryListProviderDelegate?
    var  categoryItem: [CategoryList] = []
}

extension CategoryListProvider: CategoryListProviderProtocol {
    func loadCategoryList(item: [CategoryList]) {
        self.categoryItem = item
    }
}

extension CategoryListProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryListCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? CategoryListCollectionViewCell else {
            return UICollectionViewCell()
        }
        //cell.cellViewModel = MovieListCollectionCellViewModel()
        
            cell.saveModel(item: categoryItem[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let colums: CGFloat = 2
        let with = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 30
        let width = (with - 30) / colums
        let height = width * 1.20
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            let routerData = categoryItem[indexPath.row]
            //guard let id = routerData.id else { return }
            delegate?.selected(at: routerData)
        
    }
}
