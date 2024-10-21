//
//  EndPoint.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 11.10.24.
//

import Foundation

enum EndPoint {
    case getProducts
    case getProductsDetails(id: Int)
    
    
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getProductsDetails(let id):
            return "/products/\(id)"
        }
    }
}
