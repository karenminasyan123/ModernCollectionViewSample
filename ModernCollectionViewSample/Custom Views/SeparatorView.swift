//
//  SeparatorView.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/10/20.
//

import UIKit

final class SeparatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        
        heightAnchor.constraint(equalToConstant: 1).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
