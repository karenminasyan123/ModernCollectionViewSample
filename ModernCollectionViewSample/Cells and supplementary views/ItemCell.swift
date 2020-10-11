//
//  ItemCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/7/20.
//

import UIKit

class ItemCell: UICollectionViewCell {

    static let reuseId = "SecondaryAppCellReuseId"

    var iconImageView = UIImageView()
    var titleLabel = UILabel()
    var subTitleLabel = UILabel()
    var getButton = UIButton()
    private let separatorView = SeparatorView()

    open var titlesStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    private func configureHierarchy() {
        titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, UIView()])
        titlesStackView.axis = .vertical

        [iconImageView, titlesStackView!, getButton, separatorView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        configureConstraints()
        addSeparatorView()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            iconImageView.trailingAnchor.constraint(equalTo: titlesStackView.leadingAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1.0),
            
            titlesStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titlesStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            titlesStackView.trailingAnchor.constraint(equalTo: getButton.leadingAnchor, constant: -10),
            
            getButton.widthAnchor.constraint(equalToConstant: 75),
            getButton.heightAnchor.constraint(equalToConstant: 30),
            getButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            getButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func addSeparatorView() {
        NSLayoutConstraint.activate([
            separatorView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            separatorView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    open func configureUI() {
        iconImageView.layer.cornerRadius = 15
        iconImageView.layer.masksToBounds = true

        getButton.setTitle("GET", for: .normal)
        getButton.backgroundColor = .systemGray6
        getButton.setTitleColor(.systemBlue, for: .normal)
        getButton.layer.cornerRadius = 15
        getButton.layer.masksToBounds = true
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        
        subTitleLabel.numberOfLines = 1
        subTitleLabel.font = UIFont.systemFont(ofSize: 15)
        subTitleLabel.textColor = .systemGray
    }

    // MARK: - Public API

    func setup(model: ItemModel) {
        iconImageView.image = model.iconImage
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
    
    func setSeparatorView(hidden: Bool) {
        separatorView.isHidden = hidden
    }
}
