//
//  BuilderDatail.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 10.11.24.
//

import Foundation

class DetailPresenterBuilder {
    static func build(productID: Int, view: DetailViewProtocol) -> DetailPresenter {
        let networkService = NetworkService()
        return DetailPresenter(view: view, networkService: networkService, productID: productID)
    }
}
