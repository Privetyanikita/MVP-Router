//
//  Presenter.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 19.09.24.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func configureTableView(with sections: [TableViewSectionModel])
    func showError(message: String)
}

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class MainPresenter {
    weak var view: MainViewProtocol?
    private var model: [Product] = []
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol

    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

    private func fetchProducts() {
        networkService.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.model = products
                    self?.view?.configureTableView(with: self?.createSections(from: products) ?? [])
                case .failure(let error):
                    self?.view?.showError(message: "Failed to load products: \(error.localizedDescription)")
                }
            }
        }
    }

    private func createSections(from products: [Product]) -> [TableViewSectionModel] {
        let cellModels = products.map { product in
            TableViewCellModel(
                identifier: CartViewCell.reuseID,
                onFill: { cell in
                    guard let cell = cell as? CartViewCell else { return }
                    cell.configure(with: product)
                },
                onSelect: { [weak self] in
                    guard let self = self else { return }
                    self.router.navigationToDetailScreen(view: self.view!, productID: product.id)
                }
            )
        }
        return [TableViewSectionModel(cells: cellModels)]
    }
}

extension MainPresenter: MainPresenterProtocol{    
    func viewDidLoad() {
        fetchProducts()
    }
}
