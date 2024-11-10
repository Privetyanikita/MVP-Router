//
//  DetailPresenter.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 19.09.24.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
    func configureView(product: Product)
    func showError(message: String)
}

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

class DetailPresenter {
    weak var view: DetailViewProtocol?
    private var model: Product!
    private let networkService: NetworkServiceProtocol
    private var productID: Int
    
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, productID: Int) {
        self.view = view
        self.networkService = networkService
        self.productID = productID
    }
    
    private func fetchProdct() {
        networkService.fetchProductDetails(id: productID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let product):
                    self?.view?.configureView(product: product)
                case .failure(let error):
                    self?.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func viewDidLoad(){
        fetchProdct()
    }
}
