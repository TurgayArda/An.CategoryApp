//
//  CategoryListConstant.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

class CategoryListConstant {
    enum CategoryListURL: String {
        case basic_url = "https://api.shopiroller.com/v2.0/"
        case categories_url = "categories"
        
        static func categoryListPathURL() -> String {
            return "\(basic_url.rawValue)\(categories_url.rawValue)"
        }
    }
    
    enum CategoryListConstant: String {
        case title = "Categories"
        case unknow = "Unknow"
    }
}
