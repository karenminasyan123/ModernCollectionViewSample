//
//  SectionHeadersViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/18/20.
//

import UIKit

class SectionHeadersViewController: UIViewController {

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>!
    let headerKind = "headerKind"

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
}

extension SectionHeadersViewController {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout.init(sectionProvider: { index, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: self.headerKind, alignment: .top)
            header.pinToVisibleBounds = true

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            section.boundarySupplementaryItems = [header]

            return section
        })
    }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int> {cell, indexPath, number in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = "Row \(number)"
            cell.contentConfiguration = configuration
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: headerKind, handler: { view, elementKind, indexPath in
            view.setTitle("Section \(indexPath.section)")
            view.setActionButtonHidden(true)
        })

        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, title) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: title)
        })

        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        
        let sections = Array(1...20)
        var offset = 0
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(Array(offset ..< offset + 5))
            offset = offset + 5
        }

        dataSource.apply(snapshot)
    }
}

extension SectionHeadersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
