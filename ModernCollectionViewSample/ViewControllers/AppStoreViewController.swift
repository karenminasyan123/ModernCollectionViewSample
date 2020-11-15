//
//  ViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/3/20.
//

import UIKit

class AppStoreViewController: UIViewController {
    static let headerElementKind = "header-element-kind"

    lazy var collections: [ItemCollection] = {
        let database = ItemDatabase()
        return database.getItemCollections()
    }()

    enum SectionLayoutKind: Int, CaseIterable {
        case singleRow,
             doubleRow,
             tripleRow,
             shortRow,
             list

        var rows: Int {
            switch self {
            case .singleRow: return 1
            case .doubleRow: return 2
            case .tripleRow: return 3
            case .shortRow: return 1
            case .list: return 1
            }
        }

        var groupHeight: CGFloat {
            switch self {
            case .singleRow: return 320
            case .doubleRow: return 250
            case .tripleRow: return 270
            case .shortRow: return 190
            case .list: return 45
            }
        }
        
        var groupFractionalWidth: CGFloat {
            switch self {
            case .shortRow: return 0.7
            default: return 0.91
            }
        }
        
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .list: return .none
            default: return .groupPaging
            }
        }
        
        var hasHeader: Bool {
            self != .singleRow
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<ItemCollection, ItemModel>! = nil
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"
        configureCollectionView()
        configureDataSource()
    }

    func sectionKind(sectionIndex: Int) -> SectionLayoutKind {
        let sortIndex = collections[sectionIndex].sectionKindId
        switch sortIndex {
        case 0: return .singleRow
        case 1: return .doubleRow
        case 2: return .tripleRow
        case 3: return .shortRow
        case 4: return .list
        default: return .singleRow
        }
    }
}

extension AppStoreViewController {

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let sectionKind = self.sectionKind(sectionIndex: sectionIndex)

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

            let groupWidth = layoutEnvironment.container.contentSize.width * sectionKind.groupFractionalWidth
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .absolute(sectionKind.groupHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: sectionKind.rows)

            let section = NSCollectionLayoutSection(group: group)

            if sectionKind.hasHeader {
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: AppStoreViewController.headerElementKind, alignment: .top)
                section.boundarySupplementaryItems = [header]
            }

            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 30, trailing: 16)
            section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior

            return section
        }
    }
}

extension AppStoreViewController {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    func configureDataSource() {

        let mainCellRegistration = UICollectionView.CellRegistration<MainItemCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
        }

        let itemCellRegistration = UICollectionView.CellRegistration<ItemCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
            cell.setSeparatorView(hidden: indexPath.row % 3 == 0)
        }

        let secondItemCellRegistration = UICollectionView.CellRegistration<WideItemCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
            cell.setSeparatorView(hidden: indexPath.row % 2 == 0)
        }

        let listCellRegistration = UICollectionView.CellRegistration<ListCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
            cell.setSeparatorView(hidden: indexPath.row == 0)
        }

        let categoryGridCellRegistration = UICollectionView.CellRegistration<CategoryGridCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
        }

        dataSource = UICollectionViewDiffableDataSource<ItemCollection, ItemModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, model: ItemModel) -> UICollectionViewCell? in
            let sectionKind = self.sectionKind(sectionIndex: indexPath.section)
            switch sectionKind {
            case .singleRow:
                return collectionView.dequeueConfiguredReusableCell(using: mainCellRegistration, for: indexPath, item: model)
            case .doubleRow:
                return collectionView.dequeueConfiguredReusableCell(using: secondItemCellRegistration, for: indexPath, item: model)
            case .tripleRow:
                return collectionView.dequeueConfiguredReusableCell(using: itemCellRegistration, for: indexPath, item: model)
            case .shortRow:
                return collectionView.dequeueConfiguredReusableCell(using: categoryGridCellRegistration, for: indexPath, item: model)
            case .list:
                return collectionView.dequeueConfiguredReusableCell(using: listCellRegistration, for: indexPath, item: model)
            }
        }

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: AppStoreViewController.headerElementKind) { supplementaryView, elentKind, indexPath in
            let title = self.collections[indexPath.section].title
            supplementaryView.setTitle(title)
            supplementaryView.setActionButtonTitle("See All")
        }

        dataSource.supplementaryViewProvider = { view, kind, index in
            self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<ItemCollection, ItemModel>()

        collections.forEach { collection in
            snapshot.appendSections([collection])
            snapshot.appendItems(collection.items)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension AppStoreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
