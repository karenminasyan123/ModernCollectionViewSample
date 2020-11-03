//
//  ListViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/31/20.
//

import UIKit

class PinterestLayoutViewController: UIViewController {

    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    let spacing = 10

    // Random image items
    lazy var imageItems: [ImageItem] = {
        RandomImageDatabase().getRandomImageItems()
    }()

    // Random image names
    lazy var imageNames: [String] = {
        imageItems.map(\.name)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }

    func columnsCountFor(width: CGFloat) -> Int {
        width > 600 ? 3 : 2
    }

    func getImageHeights(for cellWidth: CGFloat) -> [Int] {
        imageItems.map { (Int(cellWidth) * $0.height) / $0.width }
    }
}

extension PinterestLayoutViewController {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, environment in
            let containerWidth = environment.container.effectiveContentSize.width
            let columnsCount = self.columnsCountFor(width: containerWidth)
            let cellWidth = (Int(containerWidth) - (columnsCount + 1) * self.spacing) / columnsCount
            let imageHeights = self.getImageHeights(for: CGFloat(cellWidth))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))

            let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { (environment) -> [NSCollectionLayoutGroupCustomItem] in

                var items = [NSCollectionLayoutGroupCustomItem]()

                // set values for first row
                let xOffsets = (0 ..< columnsCount).map { $0 * cellWidth + ($0 + 1) * self.spacing }
                var yOffsets = Array(repeating: self.spacing, count: columnsCount)

                var column = 0
                // Compute frame for each item
                for height in imageHeights {
                    let height = Int(height) + self.spacing
                    let frame = CGRect(x: xOffsets[column],
                                       y: yOffsets[column],
                                       width: cellWidth,
                                       height: height)
                    items.append(NSCollectionLayoutGroupCustomItem(frame: frame))
                    // Set Next item yOffset
                    yOffsets[column] = yOffsets[column] + height + self.spacing
                    column = (column >= columnsCount - 1) ? 0 : column + 1
                }
                return items
            }

            let section = NSCollectionLayoutSection(group: group)

            return section
        }
    }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ImageCell, String> {cell, indexPath, imageName in
            cell.setImage(name: imageName)
            cell.setStyle(.rounded)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, imageName) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: imageName)
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(imageNames)
        dataSource.apply(snapshot)
    }
}

extension PinterestLayoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
