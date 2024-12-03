//
//  MainBuilder.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 10.11.24.
//

import Foundation

final class MainPresenterBuilder {
    static func build() -> MainViewController {
        let networkService = NetworkService()
        let router = Router()
        let viewController = MainViewController()
        viewController.presenter = MainPresenter(view: viewController, networkService: networkService, router: router)
        return viewController
    }
}
