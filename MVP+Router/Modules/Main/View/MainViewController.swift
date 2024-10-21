//
//  ViewController.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 19.09.24.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainPresenterProtocol!

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.register(CartViewCell.self, forCellReuseIdentifier: CartViewCell.reuseID)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 148
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        return tableView
    }()

    private var tableViewBuilder: TableViewBuilder?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        presenter.viewDidLoad()
    }
    
    private func setupView(){
        view.addSubview(tableView)
    }
    
    private func setupConstraints(){
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MainViewController: MainViewProtocol {
    
    func configureTableView(with sections: [TableViewSectionModel]) {
        tableViewBuilder = TableViewBuilder(tableView: tableView)
        tableViewBuilder?.sections = sections
        tableView.reloadData()
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
