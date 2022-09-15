//
//  ProductListViewModel.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import Foundation

final class ProductListViewModel: ProductListViewModelProtocol {
    var delegate: ProductListViewModelDelegate?
    var service: HttpClientProtocol?
    var productListID: String?
    
    init(service: HttpClientProtocol, productListID: String) {
        self.service = service
        self.productListID = productListID
    }
}

//MARK: - loadProductList(id: String, filter: String)

extension ProductListViewModel {
    func loadProductList(filter: String) {
        guard let id = productListID else { return }
        delegate?.handleOutPut(.title(ProductListConstant.ProductListPropertyConstant.title.rawValue))
        service?.fetch(url: ProductListConstant.ProductListURL.productListPathURL(id: id, filter: filter),
                       completion: { [delegate] (result: Result<ProductListResult, Error>) in
            switch result {
            case .success(let productItem):
                guard let productItemTwo =  productItem.data else { return }
                delegate?.handleOutPut(.showProductList(productItemTwo))
            case .failure(let error):
                delegate?.handleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}
