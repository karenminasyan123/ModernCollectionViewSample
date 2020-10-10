//
//  AppModel.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/4/20.
//

import UIKit

struct ItemModel: Hashable {
    let iconImage: UIImage
    let previewImage: UIImage

    let title: String
    let subTitle: String
    let commentText: String

    let identifier = UUID()

    init(iconImage: UIImage = UIImage(),
         previewImage: UIImage = UIImage(),
         title: String = "",
         subTitle: String = "",
         commentText: String = "") {
        self.iconImage = iconImage
        self.previewImage = previewImage
        self.title = title
        self.subTitle = subTitle
        self.commentText = commentText
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
