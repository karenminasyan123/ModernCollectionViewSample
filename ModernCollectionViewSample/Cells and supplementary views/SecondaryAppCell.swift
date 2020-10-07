//
//  SecondaryAppCell.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/7/20.
//

import UIKit

class SecondaryAppCell: UICollectionViewCell {

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

extension SecondaryAppCell {

    // MARK: - Configure

    private func configureHierarchy() {
        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        titlesStackView.axis = .vertical

        rightStackView = UIStackView(arrangedSubviews: [titlesStackView, getButton])
        addSubview(rightStackView)
        addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            iconImageView.rightAnchor.constraint(equalTo: rightStackView.leftAnchor, constant: -10),
            iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 1.0),

            rightStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            rightStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            rightStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 16)
        ])
    }
    
    private func configureUI() {
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true

        getButton.setTitle("GET", for: .normal)
        getButton.setTitleColor(.systemBlue, for: .normal)
    }

    // MARK: - Public API

    func setup(appModel: AppModel) {
        iconImageView.image = appModel.iconImage
        titleLabel.text = appModel.title
        subTitleLabel.text = appModel.subTitle
    }
    
    func setStyle(_ style: CellStyle) {
        self.style = style
        rightStackView.axis = style == .verticallyAligned ? .vertical : .horizontal
    }
}
