//
//  CategoryCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/10/20.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let separatorView = SeparatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell {

    // MARK: - Configure

    private func configureHierarchy() {
        [iconImageView, titleLabel, separatorView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 25),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            
            separatorView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 25),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40)
        ])
    }

    private func configureUI() {

    }

    // MARK: - Public API

    func setup(model: ItemModel) {
        iconImageView.image = model.iconImage
        titleLabel.text = model.title
    }
}
