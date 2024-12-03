//
//  Presenter.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 19.09.24.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func configureTableView(with sections: [TableViewSectionModel])
    func appendSections(_ sections: [TableViewSectionModel])
    func showError(message: String)
}

protocol MainPresenterProtocol: AnyObject {
    func viewDidLoad()
    func loadNextPage()
}

final class MainPresenter {
    weak var view: MainViewProtocol?
    private let networkService: NetworkServiceProtocol
    private let router: RouterProtocol
    
    private var products: [Product] = []
    private var isLoading = false
    private var hasMoreProducts = true
    private var offset = 0
    private let limit = 10

    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }

    private func fetchProductsWithLimit() {
        guard !isLoading, hasMoreProducts else { return }
        isLoading = true

        networkService.fetchProductsWithPagination(offset: offset, limit: limit) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let newProducts):
                    if newProducts.isEmpty {
                        self.hasMoreProducts = false
                        print("No more products to load")
                        return
                    }
                    self.products.append(contentsOf: newProducts)
                    self.offset += 10
                    self.updateView(with: self.products)
                case .failure(let error):
                    self.view?.showError(message: "Failed to load products: \(error.localizedDescription)")
                }
            }
        }
    }
       
    private func fetchProducts(){// уже не надо, но пускай будет
        networkService.fetchProducts{ [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let newProducts):
                    print(newProducts.count)
                case .failure(let error):
                    self.view?.showError(message: "Failed to load products: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func updateView(with newProducts: [Product]) {
        guard !newProducts.isEmpty else { return }
        view?.configureTableView(with: createSections(from: newProducts))
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
                    guard let self, let view else { return }
                    self.router.navigationToDetailScreen(view: view, productID: product.id)
                }
            )
        }
        return [TableViewSectionModel(cells: cellModels)]
    }
}

extension MainPresenter: MainPresenterProtocol{    
    func viewDidLoad() {
        fetchProductsWithLimit()
    }
    
    func loadNextPage() {
        guard hasMoreProducts else { return }
        fetchProductsWithLimit()
    }
}
