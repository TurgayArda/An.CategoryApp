//
//  ProductListContracts.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import UIKit

//MARK: - ViewModel

protocol ProductListViewModelProtocol {
    var delegate: ProductListViewModelDelegate? { get set }
    func loadProductList(filter: String)
}

enum ProductListViewModelOutPut {
    case showProductList([ProductList])
    case showError(String)
    case title(String)
}

protocol ProductListViewModelDelegate {
    func handleOutPut(_ output: ProductListViewModelOutPut)
}

//MARK: - Provider

protocol ProductListProviderProtocol {
    var delegate: ProductListProviderDelegate? { get set }
    func loadProductList(item: [ProductList])
}

enum ProductListProviderOutPut {
    case selectProductItem(Int)
    case title(String)
    case error(String)
}

protocol ProductListProviderDelegate {
    func selected(at select: String)
}

