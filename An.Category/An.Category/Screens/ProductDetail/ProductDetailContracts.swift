//
//  ProductDetailContracts.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

//MARK: - ViewModel

protocol ProductDetailViewModelProtocol {
    var delegate: ProductDetailViewModelDelegate? { get set }
    func loadProductDetail()
    func getDetailName() -> String
    func getDetailPrice() -> String
    func getDetailCampaignPrice() -> String
    func getDetailDescription() -> String
    func getDetailStock() -> String
}

enum ProductDetailViewModelOutPut {
    case showProductDetail(ProductDetail)
    case showError(String)
    case title(String)
}

protocol ProductDetailViewModelDelegate {
    func handleOutPut(_ output: ProductDetailViewModelOutPut)
}
