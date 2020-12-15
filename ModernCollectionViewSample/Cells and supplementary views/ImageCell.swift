//
//  ImageCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/19/20.
//

import UIKit

class ImageCell: UICollectionViewCell {

    enum Style {
        case rounded
        case shadow
    }

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
        setStyle(Style.shadow)
    }

    // MARK: - Public API

    func setImage(name: String) {
        imageView.image = UIImage(named: name)
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
    
    func setStyle(_ style: Style) {
        switch style {
        case .rounded:
            imageView.layer.cornerRadius = 15
            imageView.layer.masksToBounds = true
        case .shadow:
            imageView.layer.masksToBounds = false
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowColor = UIColor.systemGray.cgColor
            imageView.layer.shadowOffset = CGSize(width: 5,height: 5)

            // UI Performance Fix
    //        let rect = layer.bounds
    //        let shadowRect = CGRect(x: rect.minX + 5, y: rect.minY + 5, width: rect.width, height: rect.height)
    //        imageView.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
        }
    }
}
