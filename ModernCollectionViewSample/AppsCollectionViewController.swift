//
//  ViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/3/20.
//

import UIKit

class AppsCollectionViewController: UICollectionViewController {
    static let headerElementKind = "header-element-kind"

    lazy var collections: [AppCollection] = {
        let controller = AppsController()
        return controller.generateCollections()
    }()
    
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
            case .longList: return 0.3
            case .shortList: return 0.2
            case .doubleList: return 0.3
            case .trippleList: return 0.3
            case .categoryList: return 0.3
            }
        }
        
        var groupFractianalWidth: CGFloat {
            switch self {
            case .shortList: return 0.7
            default: return 0.9
            }
        }
    }

    var dataSource: UICollectionViewDiffableDataSource<AppCollection, AppModel>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Apps"
        configureHierarchy()
        configureDataSource()
    }
    
    func sectionKind(sectionIndex: Int) -> SectionKind {
        let sortIndex = collections[sectionIndex].sortIndex
        switch sortIndex {
        case 0: return .longList
        case 1: return .shortList
        case 2: return .doubleList
        case 3: return .trippleList
        default: return .longList
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
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5)

            let groupWidth = layoutEnvironment.container.contentSize.width * sectionKind.groupFractianalWidth
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(groupWidth), heightDimension: .fractionalHeight(sectionKind.groupHeight))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: sectionKind.rows)
            let section = NSCollectionLayoutSection(group: nestedGroup)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: AppsCollectionViewController.headerElementKind, alignment: .top)

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

extension AppsCollectionViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
    }
    func configureDataSource() {
        
        let largeCellRegistration = UICollectionView.CellRegistration<AppLargeCell, AppModel> { (cell, indexPath, model) in
            cell.setup(appModel: model)
        }
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, AppModel> { (cell, indexPath, model) in
            cell.backgroundColor = .red
        }
        
        dataSource = UICollectionViewDiffableDataSource<AppCollection, AppModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, model: AppModel) -> UICollectionViewCell? in
            let sectionKind = self.sectionKind(sectionIndex: indexPath.section)
            switch sectionKind {
            case .longList:
                return collectionView.dequeueConfiguredReusableCell(using: largeCellRegistration, for: indexPath, item: model)
            default:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: model)
            }
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: AppsCollectionViewController.headerElementKind) { supplementaryView, string, indexPath in
            let sectionKind = SectionKind(rawValue: indexPath.section)!
            supplementaryView.label.text = "." + String(describing: sectionKind)
        }
        
        dataSource.supplementaryViewProvider = { view, kind, index in
            self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<AppCollection, AppModel>()

        collections.forEach { collection in
            snapshot.appendSections([collection])
            snapshot.appendItems(collection.apps)
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension AppsCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
