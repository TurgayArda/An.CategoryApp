//
//  ProductDetailViewModel.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

final class ProductDetailViewModel: ProductDetailViewModelProtocol {
    var delegate: ProductDetailViewModelDelegate?
    var service: HttpClientProtocol?
    var producDetailID: String?
    var productDetailItem: ProductDetail?
    
    init(service: HttpClientProtocol, producDetailID: String) {
        self.service = service
        self.producDetailID = producDetailID
    }
}

//MARK: - loadProductDetail()

extension ProductDetailViewModel {
    func loadProductDetail() {
        guard let id = producDetailID else { return }
        service?.fetch(url: ProductDetailConstant.ProductDetailURL.productDetailPathURL(id: id),
                       completion: { [delegate] (result: Result<ProductDetailResult, Error>) in
            switch result {
            case .success(let productItem):
                guard let productItemTwo =  productItem.data else { return }
                self.productDetailItem = productItemTwo
                guard let title = productItemTwo.title else { return }
                delegate?.handleOutPut(.title(title))
                delegate?.handleOutPut(.showProductDetail(productItemTwo))
            case .failure(let error):
                delegate?.handleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}

extension ProductDetailViewModel {
    func getDetailName() -> String {
        guard let name = productDetailItem?.title else {
            return ProductDetailConstant.ProductDetailPropertyConstant.unknown.rawValue
        }
        
        return name
    }
    
    func getDetailPrice() -> String {
        guard let price = productDetailItem?.price else {
            return ProductDetailConstant.ProductDetailPropertyConstant.unknown.rawValue
        }
        
        return "\(ProductDetailConstant.ProductDetailPropertyConstant.price.rawValue): \(price)"
    }
    
    func getDetailCampaignPrice() -> String {
        guard let campaignPrice = productDetailItem?.campaignPrice else {
            return ProductDetailConstant.ProductDetailPropertyConstant.unknown.rawValue
        }
        
        return "\(ProductDetailConstant.ProductDetailPropertyConstant.campaignPrice.rawValue): \(campaignPrice)"
    }
    
    func getDetailDescription() -> String {
        guard let description = productDetailItem?.dataDescription else {
            return ProductDetailConstant.ProductDetailPropertyConstant.unknown.rawValue
        }
        
        return description
    }
    
    func getDetailStock() -> String {
        guard let stock = productDetailItem?.stock else {
            return ProductDetailConstant.ProductDetailPropertyConstant.unknown.rawValue
        }
        
        return "\(ProductDetailConstant.ProductDetailPropertyConstant.stock.rawValue): \(stock)"
    }
}
