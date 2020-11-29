//
//  RamdomImageDatabase.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 11/1/20.
//

import UIKit

struct ImageItem {
    var name: String
    var width: Int
    var height: Int
}

class RandomImageDatabase {
    func getImageNames() -> [String] {
        (1...101).map { "image\($0)" }
    }

    func getRandomImageItems() -> [ImageItem] {
        [ImageItem(name: "random1", width: 250, height: 250),
         ImageItem(name: "random2", width: 250, height: 350),
         ImageItem(name: "random3", width: 250, height: 250),
         ImageItem(name: "random4", width: 250, height: 250),
         ImageItem(name: "random5", width: 250, height: 320),
         ImageItem(name: "random6", width: 220, height: 310),
         ImageItem(name: "random7", width: 250, height: 350),
         ImageItem(name: "random8", width: 220, height: 310),
         ImageItem(name: "random9", width: 250, height: 250),
         ImageItem(name: "random10", width: 250, height: 250),
         ImageItem(name: "random11", width: 250, height: 320),
         ImageItem(name: "random12", width: 220, height: 310),
         ImageItem(name: "random13", width: 250, height: 320),
         ImageItem(name: "random14", width: 250, height: 250),
         ImageItem(name: "random15", width: 250, height: 250),
         ImageItem(name: "random16", width: 200, height: 300),
         ImageItem(name: "random17", width: 250, height: 350),
         ImageItem(name: "random18", width: 250, height: 320),
         ImageItem(name: "random19", width: 220, height: 310),
         ImageItem(name: "random20", width: 220, height: 310),
         ImageItem(name: "random21", width: 250, height: 250),
         ImageItem(name: "random22", width: 250, height: 250),
         ImageItem(name: "random23", width: 250, height: 250),
         ImageItem(name: "random24", width: 250, height: 250),
         ImageItem(name: "random25", width: 220, height: 310),
         ImageItem(name: "random26", width: 250, height: 320),
         ImageItem(name: "random27", width: 250, height: 350),
         ImageItem(name: "random28", width: 220, height: 310),
         ImageItem(name: "random29", width: 200, height: 300),
         ImageItem(name: "random30", width: 200, height: 300),
         ImageItem(name: "random31", width: 250, height: 250),
         ImageItem(name: "random32", width: 250, height: 250),
         ImageItem(name: "random33", width: 220, height: 310),
         ImageItem(name: "random34", width: 200, height: 300),
         ImageItem(name: "random35", width: 250, height: 250),
         ImageItem(name: "random36", width: 250, height: 320),
         ImageItem(name: "random37", width: 220, height: 310),
         ImageItem(name: "random38", width: 250, height: 250),
         ImageItem(name: "random39", width: 250, height: 320),
         ImageItem(name: "random40", width: 250, height: 250),
         ImageItem(name: "random41", width: 220, height: 310),
         ImageItem(name: "random42", width: 250, height: 320),
         ImageItem(name: "random43", width: 220, height: 310),
         ImageItem(name: "random44", width: 200, height: 400),
         ImageItem(name: "random45", width: 250, height: 250),
         ImageItem(name: "random46", width: 250, height: 250),
         ImageItem(name: "random47", width: 250, height: 350),
         ImageItem(name: "random48", width: 250, height: 250),
         ImageItem(name: "random49", width: 250, height: 320),
         ImageItem(name: "random50", width: 250, height: 250)]
    }
}
