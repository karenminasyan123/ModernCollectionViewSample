//
//  AppModel.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/4/20.
//

import UIKit

struct AppModel: Hashable {
    let iconImage: UIImage
    let previewImage: UIImage
    
    let title: String
    let subTitle: String
    let commentText: String
    
    let identifier = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
