//
//  Dete.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 19.09.24.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let element = UIScrollView()
        element.bounces = true
        return element
    }()
    
    private let productImage: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.backgroundColor = .clear
        element.clipsToBounds = true
        return element
    }()
    
    private let titleProductLabel: UILabel = {
        let element = UILabel()
        element.textColor = .black
        element.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        element.numberOfLines = 3
        return element
    }()
    
    private let priceProductLabel: UILabel = {
        let element = UILabel()
        element.textColor = .black
        element.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        element.numberOfLines = 3
        return element
    }()
    
    private let descriptionLabel: UILabel = {
        let element = UILabel()
        element.textColor = .systemGray
        element.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        element.numberOfLines = 0
        return element
    }()
    
    private var model: Product!
    var presenter: DetailPresenter!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .systemBackground
        presenter.viewDidLoad()
    }
    
    private func setupViews(){
        view.addSubview(scrollView)
        scrollView.add(subviews: productImage, titleProductLabel, descriptionLabel, priceProductLabel)
        setupConstrains()
    }
}

extension DetailViewController: DetailViewProtocol {
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func configureView(product: Product) {
        productImage.kf.indicatorType = .activity
        productImage.kf.setImage(with: URL(string: product.image))
        titleProductLabel.text = product.title
        priceProductLabel.text = String(product.price) + "$"
        descriptionLabel.text = product.description
    }
    
    private func setupConstrains(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        productImage.snp.makeConstraints { make in
            make.centerX.equalTo(scrollView.frameLayoutGuide)
            make.top.equalTo(scrollView.frameLayoutGuide).inset(10)
            make.height.equalTo(200)
        }
        
        titleProductLabel.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(30)
            make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(10)
        }
        
        priceProductLabel.snp.makeConstraints { make in
            make.top.equalTo(titleProductLabel.snp.bottom).offset(10)
            make.leading.equalTo(scrollView.frameLayoutGuide).inset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceProductLabel.snp.bottom).offset(15)
            make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(10)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
        }
    }
}
