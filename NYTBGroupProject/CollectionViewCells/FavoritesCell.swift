//
//  FavoritesCell.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

// TODO: Setup constraints

class FavoritesCell: UICollectionViewCell {
    
    public lazy var bookImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.backgroundColor = .systemBlue
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public lazy var bestSellerLengthLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.text = "Weeks as best seller"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = label.font.withSize(18)
        return label
    }()
    
    public lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemYellow
        label.text = "Abstract"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = label.font.withSize(17)
        return label
    }()
    
    public lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.setTitle("...", for: .highlighted)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpImageViewConstraints()
        setUpBestSellerLengthLabelConstraints()
        setUpAbstractLabelConstraints()
    }
    
    private func setUpImageViewConstraints() {
        addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setUpBestSellerLengthLabelConstraints() {
        addSubview(bestSellerLengthLabel)
        bestSellerLengthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func setUpAbstractLabelConstraints() {
        addSubview(abstractLabel)
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
        ])
    }
    
}
