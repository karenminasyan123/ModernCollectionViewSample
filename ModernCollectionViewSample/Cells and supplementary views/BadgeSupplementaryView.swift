//
//  BadgeSupplementaryView.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 12/5/20.
//

import UIKit

final class BadgeSupplementaryView: UICollectionReusableView {
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviewWithLayoutToBounds(subview: titleLabel)
        titleLabel.textAlignment = .center
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
