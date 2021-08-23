//
//  CollectionViewSectionHeader.swift
//  markup-test
//
//  Created by Max Boychenko on 06.08.2021.
//

import UIKit

final class CollectionViewSectionHeader: UICollectionViewCell {
	
	// MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Properties
	static let reuseIdentifier = "CollectionViewSectionHeader"
	private var leadingConstraint: NSLayoutConstraint!
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
}

// MARK: - UI Setup
extension CollectionViewSectionHeader {
	private func setupUI() {
		contentView.addSubview(titleLabel)
		
		leadingConstraint = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
		
		NSLayoutConstraint.activate([
			leadingConstraint,
			titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}
}

// MARK: - UI Update
extension CollectionViewSectionHeader {
	func setLeadingContaintConstant(_ constant: CGFloat) {
		leadingConstraint.constant = constant
	}
}
