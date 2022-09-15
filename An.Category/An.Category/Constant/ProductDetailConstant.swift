//
//  ProductDetailConstant.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

class ProductDetailConstant {
    enum ProductDetailURL: String {
        case basic_url = "https://api.shopiroller.com/v2.0/"
        case product_url = "products/"
        
        static func productDetailPathURL(id: String) -> String {
            return "\(basic_url.rawValue)\(product_url.rawValue)\(id)"
        }
    }
    
    enum ProductDetailPropertyConstant: String {
        case unknown = "Unknown"
        case price = "Price"
        case campaignPrice = "CampaignPrice"
        case stock = "Stock"
    }
}
