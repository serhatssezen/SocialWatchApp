//
//  Products.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 29.06.2022.
//

import Foundation

// MARK: - Products
struct Products: Codable, Hashable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Hashable {
    let id: Int
    let title, productDescription: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case id, title
        case productDescription = "description"
        case price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
}
