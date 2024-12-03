//
//  EndPoint.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 11.10.24.
//

import Foundation

enum EndPoint {
    case getProducts
    case getProductsDetails(id: Int)// ручка - сленг
    case getProductWithLimit(offset: Int, limit: Int)
    
    
    var path: String {
        switch self {
        case .getProducts:
            return "/api/v1/products"
        case .getProductsDetails(let id):
            return "/api/v1/products/\(id)"
        case .getProductWithLimit:
            return "/api/v1/products"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getProductWithLimit(let offset, let limit):
            return [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        default:
            return nil
        }
    }
}
