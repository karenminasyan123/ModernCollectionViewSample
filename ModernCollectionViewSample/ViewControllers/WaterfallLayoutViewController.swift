//
//  WaterfallLayoutViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/31/20.
//

import UIKit

 final class WaterfallLayoutViewController: UIViewController {

    enum Section {
        case main
    }

    struct ImageItem: Hashable {
        let image: UIImage
        private let identifier = UUID()

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
    }

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ImageItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }

    // Get random image names
    func getImageNames() -> [String] {
        (1...51).map { "random\($0)" }
    }

    private func columnsCountFor(width: CGFloat) -> Int {
        width > 600 ? 3 : 2
    }
}

extension WaterfallLayoutViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { _, environment in
            let spacing = 10
            let containerWidth = environment.container.effectiveContentSize.width
            let columnsCount = self.columnsCountFor(width: containerWidth)
            let cellWidth = (Int(containerWidth) - (columnsCount + 1) * spacing) / columnsCount
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))

            let group = NSCollectionLayoutGroup.custom(layoutSize: groupSize) { environment -> [NSCollectionLayoutGroupCustomItem] in

                var items = [NSCollectionLayoutGroupCustomItem]()
                // set values for the first row
                let xOffsets = (0 ..< columnsCount).map { $0 * cellWidth + ($0 + 1) * spacing }
                var yOffsets = Array(repeating: spacing, count: columnsCount)
                var groupHeights = Array(repeating: spacing, count: columnsCount)

                var column = 0
                // Compute frame for each item
                let imageItems = self.dataSource.snapshot(for: Section.main).items

                for item in imageItems {
                    let height = CGFloat(spacing) + CGFloat(cellWidth) * item.image.size.height / item.image.size.width

                    let frame = CGRect(x: xOffsets[column],
                                       y: yOffsets[column],
                                       width: cellWidth,
                                       height: Int(height))
                    items.append(NSCollectionLayoutGroupCustomItem(frame: frame))
                    // Set Next item yOffset
                    let newHeight = yOffsets[column] + Int(height) + spacing
                    yOffsets[column] = newHeight
                    groupHeights[column] += newHeight

                    column = groupHeights.firstIndex(of: groupHeights.min()!)!
                }
                return items
            }

            let section = NSCollectionLayoutSection(group: group)

            return section
        }
    }

    private func createLayout2() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] _, environment in
            guard let self = self else { return nil }
            let spacing = 10
            let containerWidth = environment.container.effectiveContentSize.width
            let columnsCount = self.columnsCountFor(width: containerWidth)
            let cellWidth = (Int(containerWidth) - (columnsCount + 1) * spacing) / columnsCount

            var groupHeights = Array(repeating: CGFloat(0.0), count: columnsCount)
            var groupItemsArray = Array(repeating: [NSCollectionLayoutItem](), count: columnsCount)
            let items = self.dataSource.snapshot(for: Section.main).items

            for item in items {
                let height = CGFloat(cellWidth) * item.image.size.height / item.image.size.width
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(height))
                let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
                layoutItem.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

                let index = groupHeights.firstIndex(of: groupHeights.min()!)!
                groupItemsArray[index].append(layoutItem)
                groupHeights[index] += height
            }

            var verticalGroups = [NSCollectionLayoutGroup]()
            for i in 0 ..< columnsCount {
                let fracWidth = 1.0 / CGFloat(columnsCount)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(fracWidth),
                                                       heightDimension: .absolute(groupHeights[i]))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             subitems:groupItemsArray[i])
                verticalGroups.append(group)
            }

            let height = groupHeights.max()!
            let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .absolute(height))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize,
                                                                    subitems: verticalGroups)

            let section = NSCollectionLayoutSection(group: containerGroup)
            return section
        }
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ImageCell, ImageItem> {cell, indexPath, item in
            cell.setImage(image: item.image)
            cell.setStyle(.rounded)
        }

        dataSource = UICollectionViewDiffableDataSource<Section, ImageItem>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, imageName) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: imageName)
        })

        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageItem>()
        snapshot.appendSections([.main])
        let items = getImageNames().map { ImageItem(image: UIImage(named: $0)!) }
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}

extension WaterfallLayoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
