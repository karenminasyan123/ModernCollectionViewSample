//
//  NestedGroupsViewController.swift
//  ModernCollectionViewSample
//
//  Created by Karen Minasyan on 10/18/20.
//

import UIKit

final class NestedGroupsViewController: UIViewController {

    enum Section {
        case main
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureDataSource()
    }
}

extension NestedGroupsViewController {
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5)

        let nestedItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let nestedItem = NSCollectionLayoutItem(layoutSize: nestedItemSize)
        nestedItem.contentInsets = NSDirectionalEdgeInsets.init(top: 5, leading: 5, bottom: 5, trailing: 5)

        let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitem: nestedItem, count: 2)

        let containerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
        let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerGroupSize, subitems: [item, nestedGroup])
        containerGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)

        let section = NSCollectionLayoutSection(group: containerGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)

        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, String> {cell, title, IndexPath in
            cell.backgroundColor = .systemIndigo
            cell.layer.borderColor = UIColor.systemBlue.cgColor
            cell.layer.borderWidth = 1
        }

        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, title) in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: title)
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems((0 ... 98).map { String($0) } )
        
        dataSource.apply(snapshot)
    }
}

extension NestedGroupsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
    }
}
