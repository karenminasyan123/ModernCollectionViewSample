/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Simple example of a self-sizing supplementary title view
*/

import UIKit

class TitleSupplementaryView: UICollectionReusableView {
    private let titleLabel = UILabel()
    private let actionButton = UIButton()
    private let separatorView = SeparatorView()

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
        [titleLabel, actionButton, separatorView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -10),

            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            actionButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            actionButton.widthAnchor.constraint(equalToConstant: 60),

            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            separatorView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }

    func configure() {
        backgroundColor = .systemBackground
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .label

        actionButton.setTitleColor(.systemBlue, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 18)
    }

    // Public API

    func setTitle(_ title: String) {
        titleLabel.text = title
    }

    func setActionButtonTitle(_ title: String) {
        actionButton.setTitle(title, for: .normal)
    }

    func setActionButtonHidden(_ hidden: Bool) {
        actionButton.isHidden = hidden
    }
}
