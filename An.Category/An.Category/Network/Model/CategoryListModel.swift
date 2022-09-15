//
//  CategoryListModel.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import Foundation

//MARK: - CategoryListResult

struct CategoryListResult: Codable {
    let success: Bool?
    let data: [CategoryList]?
}

//MARK: - CategoryList

struct CategoryList: Codable {
    let categoryID, name: String?
    let icon: String?
    let orderIndex: Int?
    let createDate, updateDate: String?
    let totalProducts: Int?
    let isActive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case name, icon, orderIndex, createDate, updateDate, totalProducts, isActive
    }
}
