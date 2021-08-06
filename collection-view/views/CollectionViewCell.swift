//
//  CollectionViewCell.swift
//  markup-test
//
//  Created by Max Boychenko on 05.08.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    // MARK: - Properties
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.systemGray.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
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
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(imageView)
        roundedBackgroundView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            roundedBackgroundView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            roundedBackgroundView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.roundedBackgroundView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.roundedBackgroundView.topAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalTo: roundedBackgroundView.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: roundedBackgroundView.widthAnchor, multiplier: 0.85),
            titleLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
        
    }
}
