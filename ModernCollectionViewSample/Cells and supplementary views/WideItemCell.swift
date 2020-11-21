//
//  SecondItemCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/10/20.
//

import UIKit

final class WideItemCell: ItemCell {
    override func configureConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            iconImageView.trailingAnchor.constraint(equalTo: titlesStackView.leadingAnchor, constant: -15),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1.0),
            
            titlesStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titlesStackView.bottomAnchor.constraint(equalTo: getButton.topAnchor, constant: -10),
            titlesStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            getButton.widthAnchor.constraint(equalToConstant: 75),
            getButton.heightAnchor.constraint(equalToConstant: 30),
            getButton.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            getButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            purchaseLabel.leadingAnchor.constraint(equalTo: getButton.trailingAnchor, constant: 5),
            purchaseLabel.centerYAnchor.constraint(equalTo: getButton.centerYAnchor)
        ])
    }

    override func configureUI() {
        super.configureUI()
        purchaseLabel.text = "In-App\nPurchases"
        purchaseLabel.numberOfLines = 2
    }
}
