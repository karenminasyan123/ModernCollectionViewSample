//
//  ImageCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/19/20.
//

import UIKit

class ImageCell: UICollectionViewCell {

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

extension ImageCell {

    // MARK: - Configure

    private func configureHierarchy() {
        addSubviewWithLayoutToBounds(subview: imageView)
    }

    private func configureUI() {
        imageView.layer.masksToBounds = false

        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowColor = UIColor.gray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 5,height: 5)

        // UI Performance Fix
//        let rect = layer.bounds
//        let shadowRect = CGRect(x: rect.minX + 5, y: rect.minY + 5, width: rect.width, height: rect.height)
//        imageView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }

    // MARK: - Public API

    func setImage(name: String) {
        imageView.image = UIImage(named: name)
    }
}
