//
//  NetworkModel.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 11.10.24.
//

import Foundation

struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let images: [String]
    let category: Category
}

struct Category: Codable {
    let id: Int
    let name: String
}
