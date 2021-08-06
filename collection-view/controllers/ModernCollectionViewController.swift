//
//  ModernCollectionViewController.swift
//  collection-view
//
//  Created by Max Boychenko on 06.08.2021.
//

import UIKit

final class ModernCollectionViewController: UIViewController {
	private typealias Datasource = UICollectionViewDiffableDataSource<Int, Product>
	private typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Product>
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
		collectionView.register(
			CollectionViewSectionHeader.self,
			forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
			withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier
		)
		collectionView.register(
			CollectionViewCell.self,
			forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier
		)
		collectionView.backgroundColor = .systemGray6
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
	private lazy var datasource: Datasource = {
		getDatasource()
	}()
	private let productSectionList = ProductSectionList.mock()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupView()
		generateData(animated: false)
	}
	
	// MARK: - setupView
	private func setupView() {
		view.backgroundColor = .systemGray6
		view.addSubview(collectionView)
		
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func collectionViewLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { [unowned self] _, _ in
			self.getSectionLayout()
		}
		return layout
	}
	
	private func getSectionLayout() -> NSCollectionLayoutSection {
		let itemHeight = NSCollectionLayoutDimension.absolute(156)
		let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(102), heightDimension: itemHeight)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											   heightDimension: itemHeight)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
		group.interItemSpacing = .fixed(14)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 40, trailing: 20)
		section.interGroupSpacing = 25
		
		addStandardHeader(toSection: section)
		
		return section
	}
	
	private func addStandardHeader(toSection section: NSCollectionLayoutSection) {
		let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
		let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
		section.boundarySupplementaryItems = [headerElement]
	}
	
	// MARK: - getDatasource
	private func getDatasource() -> Datasource {
		let datasource = Datasource(collectionView: collectionView, cellProvider: { [unowned self] collectionView, indexPath, item in
			self.cell(collectionView: collectionView, indexPath: indexPath, item: item)
		})
		
		datasource.supplementaryViewProvider = { [unowned self] (collectionView, kind, indexPath) in
			let headerView = collectionView.dequeueReusableSupplementaryView(
				ofKind: kind,
				withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier,
				for: indexPath
			) as! CollectionViewSectionHeader
			
			headerView.titleLabel.text = productSectionList[indexPath.section].title
			
			return headerView
		}
		
		return datasource
	}
	
	private func cell(collectionView: UICollectionView, indexPath: IndexPath, item: Product) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CollectionViewCell.reuseIdentifier,
			for: indexPath
		) as! CollectionViewCell
		cell.imageView.image = UIImage(named: item.imagePath)
		cell.titleLabel.text = item.title
		return cell
	}
	
	// MARK: - generateData
	private func generateData(animated: Bool) {
		var snapshot = Snapshot()
		let sections = [0, 1]
		
		snapshot.appendSections(sections)
		
		snapshot.appendItems(productSectionList[0].products, toSection: sections[0])
		snapshot.appendItems(productSectionList[1].products, toSection: sections[1])
		
		datasource.apply(snapshot, animatingDifferences: animated)
	}
}
