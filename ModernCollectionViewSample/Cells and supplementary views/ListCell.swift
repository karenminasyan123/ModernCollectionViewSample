//
//  CategoryCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/10/20.
//

import UIKit

class ListCell: UICollectionViewCell {

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

extension ListCell {

    // MARK: - Configure

    private func configureHierarchy() {
        let containerView = UIView()
        addSubviewWithLayoutToBounds(subview: containerView, insets: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        [iconImageView, titleLabel, separatorView].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: iconImageView.superview!.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: iconImageView.superview!.leftAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 25),
            titleLabel.centerYAnchor.constraint(equalTo: titleLabel.superview!.centerYAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: -40),
            
            separatorView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 25),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor, constant: -40),
            separatorView.topAnchor.constraint(equalTo: topAnchor)
            
        ])
    }

    private func configureUI() {
        titleLabel.font = UIFont.systemFont(ofSize: 23)
    }

    // MARK: - Public API

    func setup(model: ItemModel) {
        iconImageView.image = UIImage(named: model.iconName)
        titleLabel.text = model.title
    }
    
    func setSeparatorView(hidden: Bool) {
        separatorView.isHidden = hidden
    }
}
