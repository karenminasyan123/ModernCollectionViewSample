//
//  ViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/3/20.
//

import UIKit

class AppsCollectionViewController: UICollectionViewController {
    static let headerElementKind = "header-element-kind"

    lazy var collections: [ItemCollection] = {
        let itemCollections = ItemCollections()
        return itemCollections.getItemCollections()
    }()
    
    enum SectionLayoutKind: Int, CaseIterable {
        case mainList,
             doubleList,
             trippleList,
             categoryGrid,
             categoryList

        var rows: Int {
            switch self {
            case .mainList: return 1
            case .categoryGrid: return 1
            case .doubleList: return 2
            case .trippleList: return 3
            case .categoryList: return 6
            }
        }

        var groupFractionalHeight: CGFloat {
            switch self {
            case .mainList: return 0.35
            case .categoryGrid: return 0.2
            case .doubleList: return 0.25
            case .trippleList: return 0.25
            case .categoryList: return 0.3
            }
        }
        
        var groupFractionalWidth: CGFloat {
            switch self {
            case .categoryGrid: return 0.7
            default: return 0.9
            }
        }
        
        var orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
            case .categoryList: return .none
            default: return .groupPaging
            }
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<ItemCollection, ItemModel>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"
        configureHierarchy()
        configureDataSource()
    }

    func sectionKind(sectionIndex: Int) -> SectionLayoutKind {
        let sortIndex = collections[sectionIndex].sortIndex
        switch sortIndex {
        case 0: return .mainList
        case 1: return .categoryGrid
        case 2: return .doubleList
        case 3: return .trippleList
        case 4: return .categoryList
        default: return .mainList
        }
    }
}

extension AppsCollectionViewController {

    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let sectionKind = self.sectionKind(sectionIndex: sectionIndex)
            // The group auto-calculates the actual item width to make
            // the requested number of columns fit, so this widthDimension is ignored.
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

            let groupWidth = layoutEnvironment.container.contentSize.width * sectionKind.groupFractionalWidth
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .fractionalHeight(sectionKind.groupFractionalHeight))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: sectionKind.rows)

            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: AppsCollectionViewController.headerElementKind, alignment: .top)

            section.boundarySupplementaryItems = [header]
            // add leading and trailing insets to the section so groups are aligned to the center
//            let sectionSideInset = (layoutEnvironment.container.contentSize.width - groupWidth) / 2
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)

            section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            return section
        }
    }
}

extension AppsCollectionViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    func configureDataSource() {
        
        let PrimaryCellRegistration = UICollectionView.CellRegistration<MainItemCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, ItemModel> { cell, indexPath, model in
            cell.backgroundColor = .red
        }
        
        let secondaryCellRegistration = UICollectionView.CellRegistration<ItemCell, ItemModel> { cell, indexPath, model in
            let sectionKind = self.sectionKind(sectionIndex: indexPath.section)
            cell.setStyle(sectionKind == .doubleList ? .verticallyAligned : .horizontallyAligned)
            cell.setup(model: model)
        }
        
        let categoryListCellRegistration = UICollectionView.CellRegistration<CategoryCell, ItemModel> { cell, indexPath, model in
            cell.setup(model: model)
        }
        
        dataSource = UICollectionViewDiffableDataSource<ItemCollection, ItemModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, model: ItemModel) -> UICollectionViewCell? in
            let sectionKind = self.sectionKind(sectionIndex: indexPath.section)
            switch sectionKind {
            case .mainList:
                return collectionView.dequeueConfiguredReusableCell(using: PrimaryCellRegistration, for: indexPath, item: model)
            case .doubleList:
                return collectionView.dequeueConfiguredReusableCell(using: secondaryCellRegistration, for: indexPath, item: model)
            case .trippleList:
                return collectionView.dequeueConfiguredReusableCell(using: secondaryCellRegistration, for: indexPath, item: model)
            case .categoryList:
                return collectionView.dequeueConfiguredReusableCell(using: categoryListCellRegistration, for: indexPath, item: model)
            default:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: model)
            }
        }

        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: AppsCollectionViewController.headerElementKind) { supplementaryView, string, indexPath in
            let sectionKind = SectionLayoutKind(rawValue: 0)!
            supplementaryView.setTitle("." + String(describing: sectionKind))
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

extension AppsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
