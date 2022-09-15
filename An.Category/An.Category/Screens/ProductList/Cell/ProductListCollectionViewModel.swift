//
//  ProductListCollectionViewModel.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import Foundation

protocol  ProductListCollectionCellViewModelProtocol {
    func getName(item: ProductList) -> String
    func getPrice(item: ProductList) -> String
    func getCampaignPrice(item: ProductList) -> String
}

class ProductListCollectionCellViewModel: ProductListCollectionCellViewModelProtocol {
    func getName(item: ProductList) -> String {
        guard let name = item.title else {
            return ProductListConstant.ProductListPropertyConstant.unknown.rawValue
        }
        
        return name
    }
    
    func getPrice(item: ProductList) -> String {
        guard let price = item.price else {
            return ProductListConstant.ProductListPropertyConstant.unknown.rawValue
        }
        
        return "\(ProductListConstant.ProductListPropertyConstant.price.rawValue): \(price)"
    }
    
    func getCampaignPrice(item: ProductList) -> String {
        guard let campaignPrice = item.campaignPrice else {
            return ProductListConstant.ProductListPropertyConstant.unknown.rawValue
        }
        
        return "\(ProductListConstant.ProductListPropertyConstant.campaignPrice.rawValue): \(campaignPrice)"
    }
}
