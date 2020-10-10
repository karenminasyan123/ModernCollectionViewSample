//
//  MainItemCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/4/20.
//

import UIKit

class MainItemCell: UICollectionViewCell {

    private let commentLabel = UILabel()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainItemCell {

    // MARK: - Configure

    private func configureHierarchy() {
        let stackView = UIStackView(arrangedSubviews: [commentLabel, titleLabel, subTitleLabel, imageView])
        stackView.frame = bounds
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 4
        addSubview(stackView)
    }
    
    private func configureUI() {
        commentLabel.numberOfLines = 1
        commentLabel.textColor = .systemBlue

        titleLabel.numberOfLines = 1

        subTitleLabel.numberOfLines = 1
        subTitleLabel.textColor = .systemGray
        
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
    }

    // MARK: - Public API

    func setup(model: ItemModel) {
        commentLabel.text = model.commentText
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        imageView.image = model.previewImage
    }
}
