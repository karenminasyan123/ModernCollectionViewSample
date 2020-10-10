/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Simple example of a self-sizing supplementary title view
*/

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    private let titleLabel = UILabel()
    private let seeAllButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension TitleSupplementaryView {

    private func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(seeAllButton)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: seeAllButton.leftAnchor, constant: -10),

            seeAllButton.rightAnchor.constraint(equalTo: rightAnchor),
            seeAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    func configure() {
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    // Public API
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
}
