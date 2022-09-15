//
//  ProductDetailBuilder.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

final class ProductDetailBuilder {
    static func make(id: String) -> ProductDetailVC {
        let view = ProductDetailVC()
        let viewModel = ProductDetailViewModel(service: HttpClient(), producDetailID: id)
        view.productDetailViewModel = viewModel
        return view
    }
}
