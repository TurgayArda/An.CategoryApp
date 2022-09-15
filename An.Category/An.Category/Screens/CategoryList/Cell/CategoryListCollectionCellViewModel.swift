//
//  CategoryListCollectionCellViewModel.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import Foundation

protocol CategoryListCollectionCellViewModelProtocol {
    func getName(item: CategoryList) -> String
}

class CategoryListCollectionCellViewModel: CategoryListCollectionCellViewModelProtocol {
    func getName(item: CategoryList) -> String {
        guard let name = item.name else {
            return CategoryListConstant.CategoryListConstant.unknow.rawValue
        }
        
        return name
    }

}
