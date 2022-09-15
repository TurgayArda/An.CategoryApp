//
//  FilterListConstant.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

final class FilterListConstant {
    enum FilterItemName: String {
        case price = "Price"
        case title = "Title"
        case publishmentDate = "PublishmentDate"
    }
    
    static let AllFilterItem = [FilterListConstant.FilterItemName.price.rawValue,
                                  FilterListConstant.FilterItemName.title.rawValue,
                                  FilterListConstant.FilterItemName.publishmentDate.rawValue,
    ]
    
    enum buttonConstantTitle: String {
        case filter = "Filter"
        case clear = "Clear"
    }
}
