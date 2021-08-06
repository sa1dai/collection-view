import UIKit

final class CollectionViewController: UIViewController {
	
	// MARK: - Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	// MARK: - Properties
	private let productSectionList = ProductSectionList.mock()
	
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
		collectionView.dataSource = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		return collectionView
	}()
}

// MARK: - UI Setup
extension CollectionViewController {
	private func setupUI() {
		view.backgroundColor = .systemGray6
		view.addSubview(collectionView)
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	private func collectionViewLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewFlowLayout()
		
		layout.sectionInset = UIEdgeInsets(
			top: 30,
			left: 20,
			bottom: 40,
			right: 20
		)
		layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 44)
		layout.scrollDirection = .vertical
		layout.minimumInteritemSpacing = 14
		layout.minimumLineSpacing = 25
		layout.itemSize = CGSize(
			width: (
				UIScreen.main.bounds.width
					- layout.sectionInset.left
					- layout.sectionInset.right
					- layout.minimumInteritemSpacing * 2
			) / 3,
			height: 156
		)
		
		return layout
	}
}

// MARK: - Data Source
extension CollectionViewController: UICollectionViewDataSource {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return productSectionList.sectionsCount
	}
	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let headerView = collectionView.dequeueReusableSupplementaryView(
			ofKind: kind,
			withReuseIdentifier: CollectionViewSectionHeader.reuseIdentifier,
			for: indexPath
		) as! CollectionViewSectionHeader
		
		let leadingContraintConstant = (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.left
		headerView.setLeadingContaintConstant(leadingContraintConstant)
		
		switch kind {
		case UICollectionView.elementKindSectionHeader:
			headerView.titleLabel.text = productSectionList[indexPath.section].title
		default:
			assertionFailure("Unexpected element kind")
		}
		
		return headerView
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return productSectionList[section].productsCount
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: CollectionViewCell.reuseIdentifier,
			for: indexPath
		) as! CollectionViewCell
		cell.imageView.image = productSectionList.getProductImage(by: indexPath)
		cell.titleLabel.text = productSectionList.getProductTitle(by: indexPath)
		return cell
	}
	
}
