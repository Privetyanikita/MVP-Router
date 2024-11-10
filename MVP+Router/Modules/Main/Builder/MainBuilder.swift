//
//  MainBuilder.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 10.11.24.
//

import Foundation

class MainPresenterBuilder {
    static func build(with view: MainViewProtocol) -> MainPresenter {
        let networkService = NetworkService()
        let router = Router()
        return MainPresenter(view: view, networkService: networkService, router: router)
    }
}
