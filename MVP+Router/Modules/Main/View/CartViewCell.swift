//
//  CartViewCell.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 11.10.24.
//

import UIKit
import SnapKit
import Kingfisher

final class CartViewCell: UITableViewCell {
    
    private let viewForCell:UIView = {
        let element = UIView()
        element.backgroundColor = .black
        element.layer.cornerRadius = 8
        element.clipsToBounds = true
        return element
    }()
    
    private let productImageView: UIImageView = {
        let element = UIImageView()
        element.contentMode = .scaleAspectFit
        element.clipsToBounds = true
        element.backgroundColor = .clear
        return element
    }()
    
    private let nameProductLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return element
    }()
    
    private let priceProductLabel: UILabel = {
        let element = UILabel()
        element.textColor = .green
        element.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return element
    }()
    
    static let reuseID = String(describing: CartViewCell.self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    private func setupView(){
        contentView.add(subviews: viewForCell, productImageView, nameProductLabel, priceProductLabel)
    }
    
    func configure(with model: Product) {
        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(with: URL(string: model.image))
        nameProductLabel.text = "\(model.title)$"
        priceProductLabel.text = String(model.price)
    }
}

extension CartViewCell {
    
    private func setupConstraints(){
        viewForCell.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(140)
        }
        
        productImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(viewForCell.snp.bottom)
            make.width.equalTo(150)
        }
        
        nameProductLabel.snp.makeConstraints { make in
            make.top.equalTo(viewForCell.snp.top).offset(19)
            make.leading.equalTo(productImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(54)
        }
        
        priceProductLabel.snp.makeConstraints { make in
            make.trailing.equalTo(viewForCell.snp.trailing).inset(10)
            make.bottom.equalTo(viewForCell.snp.bottom).inset(10)
        }
    }
}
