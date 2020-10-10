//
//  ItemCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/7/20.
//

import UIKit

class ItemCell: UICollectionViewCell {

    static let reuseId = "SecondaryAppCellReuseId"

    enum CellStyle {
        case verticallyAligned
        case horizontallyAligned
    }

    var style = CellStyle.horizontallyAligned
    
    private var iconImageView = UIImageView()
    private var titleLabel = UILabel()
    private var subTitleLabel = UILabel()
    private var getButton = UIButton()
    
    private var rightStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ItemCell {

    // MARK: - Configure

    private func configureHierarchy() {
        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        titlesStackView.axis = .vertical
        
        let buttonContainer = UIView()
        buttonContainer.addSubview(getButton)
        
        rightStackView = UIStackView(arrangedSubviews: [titlesStackView, buttonContainer])
        addSubview(rightStackView)
        addSubview(iconImageView)

        [iconImageView, rightStackView, buttonContainer, getButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            iconImageView.rightAnchor.constraint(equalTo: rightStackView.leftAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1.0),

            getButton.widthAnchor.constraint(equalToConstant: 75),
            getButton.heightAnchor.constraint(equalToConstant: 30),
            getButton.leftAnchor.constraint(equalTo: buttonContainer.leftAnchor, constant: 5),
            getButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            
            rightStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rightStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            rightStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 16)
        ])
    }
    
    private func configureUI() {
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true

        getButton.setTitle("GET", for: .normal)
        getButton.backgroundColor = .systemGray6
        getButton.setTitleColor(.systemBlue, for: .normal)
        getButton.layer.cornerRadius = 15
        getButton.layer.masksToBounds = true
    }

    // MARK: - Public API

    func setup(model: ItemModel) {
        iconImageView.image = model.iconImage
        titleLabel.text = model.title
        subTitleLabel.text = model.subTitle
    }
    
    func setStyle(_ style: CellStyle) {
        self.style = style
        rightStackView.axis = style == .verticallyAligned ? .vertical : .horizontal
    }
}
