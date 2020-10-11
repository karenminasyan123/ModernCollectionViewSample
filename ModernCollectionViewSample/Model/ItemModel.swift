//
//  AppModel.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/4/20.
//

import UIKit

struct ItemModel: Hashable {
    let iconName: String
    let previewImageName: String

    let title: String
    let subTitle: String
    let commentText: String

    let identifier = UUID()

    init(iconName: String = "",
         previewImageName: String = "",
         title: String = "",
         subTitle: String = "",
         commentText: String = "") {
        self.iconName = iconName
        self.previewImageName = previewImageName
        self.title = title
        self.subTitle = subTitle
        self.commentText = commentText
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
