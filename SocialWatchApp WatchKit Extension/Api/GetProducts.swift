//
//  GetProducts.swift
//  SocialWatchApp WatchKit Extension
//
//  Created by Aydın Serhat SEZEN on 29.06.2022.
//

import Foundation

struct GetProducts: Request {
     typealias ReturnType = Products
     var path: String = "/products"
}
