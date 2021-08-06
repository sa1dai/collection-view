//
//  CollectionViewCell.swift
//  markup-test
//
//  Created by Max Boychenko on 05.08.2021.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {
	
	// MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()

		layer.shadowPath = UIBezierPath(
			roundedRect: bounds,
			cornerRadius: contentView.layer.cornerRadius
		).cgPath
	}
	
	// MARK: - Properties
	static let reuseIdentifier = "CollectionViewCell"
	
	let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
		label.textColor = .black
		label.textAlignment = .center
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
}

// MARK: - UI Setup
extension CollectionViewCell {
	private func setupUI() {
		setupContentView()
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
			imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			imageView.heightAnchor.constraint(equalToConstant: 102),
			titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
			titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
			titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
			titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11)
		])
	}
	
	private func setupContentView() {
		contentView.addSubview(imageView)
		contentView.addSubview(titleLabel)
		
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 16.0
		contentView.layer.masksToBounds = false
		contentView.layer.shadowColor = CGColor(red: 0.908, green: 0.908, blue: 0.908, alpha: 0.6)
		contentView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
		contentView.layer.shadowRadius = contentView.layer.cornerRadius
		contentView.layer.shadowOpacity = 1.0
	}
}
