//
//  CategoryListContracts.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import UIKit

//MARK: - ViewModel

protocol CategoryListViewModelProtocol {
    var delegate: CategoryListViewModelDelegate? { get set }
    func load()
}

enum CategoryListViewModelOutPut {
    case showCategoryList([CategoryList])
    case showError(String)
    case title(String)
}

protocol CategoryListViewModelDelegate {
    func handleOutPut(_ output: CategoryListViewModelOutPut)
}

//MARK: - Provider

protocol CategoryListProviderProtocol {
    var delegate: CategoryListProviderDelegate? { get set }
    func loadCategoryList(item: [CategoryList])
}

enum CategoryListProviderOutPut {
    case selectCategoryItem(Int)
    case title(String)
    case error(String)
}

protocol CategoryListProviderDelegate {
    func selected(at select: String)
}


