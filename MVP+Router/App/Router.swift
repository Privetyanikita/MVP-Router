//
//  Router.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 19.09.24.
//

import UIKit

protocol RouterProtocol {
    func navigationToDetailScreen(view: MainViewProtocol, productID: Int)
    func navigationBack(from view: DetailViewProtocol)
}

final class Router: RouterProtocol { // на каждый екран свой роутер
    func navigationToDetailScreen(view: MainViewProtocol, productID: Int) {
        guard let viewController = view as? UIViewController else { return }
        let deteilModule = DetailPresenterBuilder.build(productID: productID)
        viewController.navigationController?.pushViewController(deteilModule, animated: true)
    }
    
    func navigationBack(from view: DetailViewProtocol) {
        guard let viewController = view as? UIViewController else { return }
        viewController.navigationController?.popViewController(animated: true)
    }
}
