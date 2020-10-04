//
//  ViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/3/20.
//

import UIKit

class SampleCollectionViewController: UICollectionViewController {
    static let headerElementKind = "header-element-kind"

    enum SectionKind: Int, CaseIterable {
        case longList,
             shortList,
             doubleList,
             trippleList,
             categoryList
        
        var rows: Int {
            switch self {
            case .longList: return 1
            case .shortList: return 1
            case .doubleList: return 2
            case .trippleList: return 3
            case .categoryList: return 6
            }
        }
        
        var groupHeight: CGFloat {
            switch self {
            case .longList: return 300
            case .shortList: return 200
            case .doubleList: return 300
            case .trippleList: return 300
            case .categoryList: return 300
            }
        }
        
        var groupFractianalWidth: CGFloat {
            switch self {
            case .shortList: return 0.7
            default: return 0.9
            }
        }
    }
    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"
        configureHierarchy()
        configureDataSource()
    }
}

extension SampleCollectionViewController {

    func createLayout(count: Int = 1, height: CGFloat = 150) -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in

            let sectionKind = SectionKind(rawValue: sectionIndex)!
            // The group auto-calculates the actual item width to make
            // the requested number of columns fit, so this widthDimension is ignored.
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)

            let groupWidth = layoutEnvironment.container.contentSize.width * sectionKind.groupFractianalWidth
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(sectionKind.groupHeight))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: sectionKind.rows)
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: SampleCollectionViewController.headerElementKind, alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            // add leading and trailing insets to the section so groups are aligned to the center
//            let sectionSideInset = (layoutEnvironment.container.contentSize.width - groupWidth) / 2
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

            section.orthogonalScrollingBehavior = .groupPaging
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
    }
}

extension SampleCollectionViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Int> { (cell, indexPath, identifier) in
            cell.backgroundColor = .red
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            // Return the cell.
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: SampleCollectionViewController.headerElementKind) { supplementaryView, string, indexPath in
            let sectionKind = SectionKind(rawValue: indexPath.section)!
            supplementaryView.label.text = "." + String(describing: sectionKind)
        }
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 18
        SectionKind.allCases.forEach {
            snapshot.appendSections([$0.rawValue])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapshot.appendItems(Array(identifierOffset ..< maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SampleCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
