//
//  ProductListBuilder.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import Foundation

final class ProductListBuilder {
    static func make(id: String) -> ProductListVC {
        let view = ProductListVC()
        let viewModel = ProductListViewModel(service: HttpClient(), productListID: id)
        view.productListViewModel = viewModel
        return view
    }
}
