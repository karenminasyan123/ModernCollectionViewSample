//
//  ScrollBehavioursViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/19/20.
//

import UIKit

class ScrollBehaviorsViewController: UIViewController {

    enum SectionKind: Int, CaseIterable {
        case continuous,
             continuousGroupLeadingBoundary,
             paging,
             groupPaging,
             groupPagingCentered,
             none
        
        func orthogonalScrollingBehaviour() -> UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .continuous:
                return .continuous
            case .continuousGroupLeadingBoundary:
                return .continuousGroupLeadingBoundary
            case .paging:
                return .paging
            case .groupPaging:
                return .groupPaging
            case .groupPagingCentered:
                return .groupPagingCentered
            case .none:
                return .none
            }
        }
    }

    let headerKind = "headerKind"
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    func columnsCount(for width: CGFloat) -> Int {
        width > 600 ? 3 : 2
    }
}

extension ScrollBehaviorsViewController {
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
            let sectionKind = SectionKind(rawValue: index)!
            let columnsCount = self.columnsCount(for: environment.container.effectiveContentSize.width)

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 10, leading: 10, bottom: 10, trailing: 10)

            let heightFraction = 1 / CGFloat(columnsCount)
            let widthFraction: CGFloat = sectionKind == .none ? 1 : 0.9
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthFraction), heightDimension: .fractionalWidth(heightFraction))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columnsCount)

            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: self.headerKind, alignment: .top)
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header]
            section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehaviour()

            return section
        })
    }

    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ImageCell, String> { cell, indexPath, imageName in
            cell.setImage(name: imageName)
        }

        let headerRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: headerKind) { view, elementKind, indexPath in
            let sectionKind = SectionKind(rawValue: indexPath.section)!
            view.setTitle(String(describing: sectionKind))
        }

        dataSource = UICollectionViewDiffableDataSource<SectionKind, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, imageName) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: imageName)
        })

        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }

        var snapshot = NSDiffableDataSourceSnapshot<SectionKind, String>()
        let images = Database().getImageNames()

        var offset = 0
        SectionKind.allCases.forEach {
            if offset + 10 < images.count {
                snapshot.appendSections([$0])
                snapshot.appendItems(Array(images[offset ..< offset + 10]))
                offset = offset + 10
            }
        }

        dataSource.apply(snapshot)
    }
}

extension ScrollBehaviorsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
