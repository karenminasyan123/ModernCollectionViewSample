//
//  SectionHeadersViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/18/20.
//

import UIKit

final class SupplementaryItemsViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    private let headerKind = "headerKind"
    private let badgeKind = "badgeKind"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
}

extension SupplementaryItemsViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let badgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.3, y: -0.3))
        let badgeSize = NSCollectionLayoutSize(widthDimension: .absolute(20), heightDimension: .absolute(20))
        let badge = NSCollectionLayoutSupplementaryItem(layoutSize: badgeSize, elementKind: badgeKind, containerAnchor: badgeAnchor)

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize, supplementaryItems: [badge])
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: headerKind, alignment: .top)
        header.pinToVisibleBounds = true
        header.zIndex = 2

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCell, Int> {cell, indexPath, number in
            cell.setTitle("\(number)")
            cell.backgroundColor = .systemIndigo
            cell.layer.cornerRadius = 5
        }

        let badgeRegistration = UICollectionView.SupplementaryRegistration<BadgeSupplementaryView>(elementKind: badgeKind) { (view, elementKind, indexPath) in
            view.backgroundColor = .systemBlue
            view.setTitle("\(indexPath.row)")
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: headerKind, handler: { view, elementKind, indexPath in
            view.setTitle("Section \(indexPath.section)")
            view.setActionButtonHidden(true)
        })

        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, title) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: title)
        })

        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            switch elementKind {
            case self.headerKind:
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
            case self.badgeKind:
                return collectionView.dequeueConfiguredReusableSupplementary(using: badgeRegistration, for: indexPath)
            default:
                return nil
            }
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()

        let sections = Array(1...20)
        var offset = 0
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(Array(offset ..< offset + 8))
            offset = offset + 8
        }

        dataSource.apply(snapshot)
    }
}

extension SupplementaryItemsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
