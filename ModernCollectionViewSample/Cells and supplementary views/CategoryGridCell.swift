//
//  CategoryGridCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/10/20.
//

import UIKit

final class CategoryGridCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryGridCell {

    // MARK: - Configure

    private func configureHierarchy() {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        addSubviewWithLayoutToBounds(subview: stackView, insets: UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0))

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    private func configureUI() {
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }

    // MARK: - Public API

    func setup(title: String, imageName: String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
    }
}
