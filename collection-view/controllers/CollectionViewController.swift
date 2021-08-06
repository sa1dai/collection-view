import UIKit

class CollectionViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Properties
    let collectionViewSectionHeaderId = "CollectionViewSectionHeader"
    let collectionViewCellId = "CollectionViewCell"
    let productSectionList = ProductSectionList.mock()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(
            CollectionViewSectionHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: collectionViewSectionHeaderId
        )
        collectionView.register(
            CollectionViewCell.self,
            forCellWithReuseIdentifier: collectionViewCellId
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
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10
        )
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let width = UIScreen.main.bounds.width / 2 - 20
        let height = width * 1.3
        layout.itemSize = CGSize(width: width, height: height)
        
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
            withReuseIdentifier: collectionViewSectionHeaderId,
            for: indexPath
        ) as! CollectionViewSectionHeader
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            headerView.titleLabel.text = productSectionList[indexPath.section].title
        default:
            assert(false, "Unexpected element kind")
        }
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productSectionList[section].productsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: collectionViewCellId,
            for: indexPath
        ) as! CollectionViewCell
        cell.imageView.image = productSectionList.getProductImage(by: indexPath)
        cell.titleLabel.text = productSectionList.getProductTitle(by: indexPath)
        return cell
    }
    
}
