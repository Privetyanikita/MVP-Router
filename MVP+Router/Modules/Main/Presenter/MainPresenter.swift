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

    init(view: MainViewProtocol) {
        self.view = view
    }

    func viewDidLoad() {
        fetchProducts()
    }

    private func fetchProducts() {
        NetworkLayer.shared.fetchProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self?.model = products
                    self?.view?.configureTableView(with: self?.createSections(from: products) ?? [])
                case .failure(let error):
                    self?.view?.showError(message: "Failed to load products: \(error)")
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
                }
            )
        }
        return [TableViewSectionModel(cells: cellModels)]
    }
}
