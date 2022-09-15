//
//  ProductDetailModel.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import Foundation

// MARK: - ProductDetailResult

struct ProductDetailResult: Codable {
    let success: Bool?
    let data: ProductDetail?
}

// MARK: - ProductDetail

struct ProductDetail: Codable {
    let id: String?
    let title: String?
    let featuredImage: FeaturedImageDetail?
    let images: [FeaturedImageDetail]?
    let dataDescription: String?
    let stock: Int?
    let stockCode: String?
    let price: Double?
    let campaignPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, featuredImage, images
        case dataDescription = "description"
        case stock, stockCode, price, campaignPrice
    }
}

// MARK: - FeaturedImage

struct FeaturedImageDetail: Codable {
    let t, n: String?
}
