
import Foundation

//MARK: - ProductListResult

struct ProductListResult: Codable {
    let success: Bool?
    let data: [ProductList]?
}

//MARK: - ProductList

struct ProductList: Codable {
    let id: String?
    let title: String?
    let featuredImage: FeaturedImage?
    let images: [FeaturedImage]?
    let price: Double?
    let campaignPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title, featuredImage, images
        case price, campaignPrice
    }
}


// MARK: - FeaturedImage

struct FeaturedImage: Codable {
    let t, n: String?
}
