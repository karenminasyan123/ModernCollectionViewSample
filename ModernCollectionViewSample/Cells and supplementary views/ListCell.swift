//
//  ListCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 11/30/20.
//

import UIKit

final class ListCell: UICollectionViewCell {

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewWithLayoutToBounds(subview: titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 23)
        titleLabel.textAlignment = .center
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
