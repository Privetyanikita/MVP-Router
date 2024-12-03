//
//  BuilderDatail.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 10.11.24.
//

import Foundation

final class DetailPresenterBuilder {
    static func build(productID: Int) -> DetailViewController {
        let networkService = NetworkService()
        let viewController = DetailViewController()
        viewController.presenter = DetailPresenter(view: viewController, networkService: networkService, productID: productID)
        return viewController
    }
}
