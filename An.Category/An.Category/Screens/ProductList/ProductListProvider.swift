//
//  ProductListProvider.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import UIKit

class  ProductListProvider: NSObject {
    var delegate:  ProductListProviderDelegate?
    var productItem: [ProductList] = []
}

extension ProductListProvider: ProductListProviderProtocol {
    func loadProductList(item: [ProductList]) {
        self.productItem = item
    }
}

extension ProductListProvider: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? ProductListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.cellViewModel = ProductListCollectionCellViewModel()
        
        cell.saveModel(item: productItem[indexPath.row])
        
        
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
        
        let routerData = productItem[indexPath.row]
        guard let id = routerData.id else { return }
        delegate?.selected(at: id)
        
    }
}
