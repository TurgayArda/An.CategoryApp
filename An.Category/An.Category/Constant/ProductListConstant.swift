//
//  ProductListConstant.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import Foundation

class ProductListConstant {
    enum ProductListURL: String {
        case basic_url = "https://api.shopiroller.com/v2.0/"
        case product_url = "products/"
        case filter_url = "advanced-filtered?categoryId="
        case sort_url = "&sort="
        
        static func productListPathURL(id: String, filter: String) -> String {
            return "\(basic_url.rawValue)\(product_url.rawValue)\(filter_url.rawValue)\(id)\(sort_url.rawValue)\(filter)"
        }
    }
    
    enum ProductListPropertyConstant: String {
        case title = "Products"
        case unknown = "Unknown"
        case price = "Price"
        case campaignPrice = "CampaignPrice"
    }
}
