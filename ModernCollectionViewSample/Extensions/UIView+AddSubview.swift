//
//  UIView+AddSubview.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/10/20.
//

import UIKit

extension UIView {
    func addSubviewWithLayoutToBounds(subview: UIView, insets: UIEdgeInsets = .zero) {
        addSubview(subview)
        addConstraintToBounds(subView: subview, insets: insets)
    }

    func insertSubviewWithLayoutToBounds(subview: UIView,
                                         at index: Int,
                                         insets: UIEdgeInsets = .zero) {
        insertSubview(subview, at: index)
        addConstraintToBounds(subView: subview, insets: insets)
    }

    private func addConstraintToBounds(subView: UIView, insets: UIEdgeInsets) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
            subView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            subView.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
            subView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
    }
}
