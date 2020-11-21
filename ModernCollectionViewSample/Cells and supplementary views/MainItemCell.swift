//
//  MainItemCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/4/20.
//

import UIKit

final class MainItemCell: UICollectionViewCell {

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
        let titlesStackView = UIStackView(arrangedSubviews: [commentLabel, titleLabel, subTitleLabel])
        titlesStackView.axis = .vertical

        let stackView = UIStackView(arrangedSubviews: [SeparatorView(), titlesStackView, imageView])
        stackView.frame = bounds
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 12
        addSubview(stackView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }

    private func configureUI() {
        commentLabel.numberOfLines = 1
        commentLabel.textColor = .systemBlue
        commentLabel.font = UIFont.boldSystemFont(ofSize: 12)

        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 22)

        subTitleLabel.numberOfLines = 1
        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = UIFont.systemFont(ofSize: 22)

        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.contentMode = .redraw
    }

    // MARK: - Public API

    func setup(model: ItemModel) {
        commentLabel.text = model.commentText.uppercased()
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
        imageView.image = UIImage(named: model.previewImageName)
    }
}
