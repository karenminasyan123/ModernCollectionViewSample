//
//  SamplesViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/17/20.
//

import UIKit

private let reuseIdentifier = "Cell"

class MenuViewController: UICollectionViewController {

    enum Section {
        case main
    }

    struct MenuItem: Hashable {
        let title: String
        let viewControllerType: UIViewController.Type

        private let identifier = UUID()

        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
            return lhs.identifier == rhs.identifier
        }

        static func getMenuItems() -> [MenuItem] {
            [MenuItem(title: "Grid Sample", viewControllerType: GridViewController.self),
             MenuItem(title: "Adaptive Grid Sample", viewControllerType: AdaptiveGridViewController.self),
             MenuItem(title: "Section Headers Sample", viewControllerType: SectionHeadersViewController.self),
             MenuItem(title: "Nested Groups Sample", viewControllerType: NestedGroupsViewController.self),
             MenuItem(title: "Different Scroll Behaviors", viewControllerType: ScrollBehaviorsViewController.self),
             MenuItem(title: "App Store Sample", viewControllerType: AppStoreViewController.self),
             MenuItem(title: "Pinterest layout", viewControllerType: PinterestLayoutViewController.self)]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, MenuItem>! = nil
}

extension MenuViewController {

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
    }

    func createLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, MenuItem> { cell, indexPath, menuItem in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = menuItem.title
            cell.contentConfiguration = configuration
        }

        dataSource = UICollectionViewDiffableDataSource<Section, MenuItem>(collectionView: collectionView) { collectionView, indexPath, menuItem in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: menuItem)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, MenuItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(MenuItem.getMenuItems())

        dataSource.apply(snapshot)
    }
}

extension MenuViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let menuItem = dataSource.itemIdentifier(for: indexPath)
        if let viewController = menuItem?.viewControllerType.init() {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

