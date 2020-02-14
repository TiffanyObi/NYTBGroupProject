//
//  FavoritesCell.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import ImageKit

protocol FavoritesCellDelegate: AnyObject {
    func didSelectMoreButton(_ favoritesCell: FavoritesCell, book: Book)
}

class FavoritesCell: UICollectionViewCell {
    
    private var currentBook: Book!
    
    weak var delegate: FavoritesCellDelegate?
    
    public lazy var bookImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.fill")
        image.backgroundColor = .systemBackground
        image.contentMode = .scaleToFill
        return image
    }()
    
    public lazy var bestSellerLengthLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "Weeks as best seller"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    public lazy var abstractTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.text = "Abstract"
        
        textView.textAlignment = .left
        textView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return textView
    }()
    
    public lazy var moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        //button.setTitle("...", for: .normal)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonPressed(_:)), for: .touchUpInside)
        
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
        setupMoreButtonConstraints()
    }
    
    @objc private func moreButtonPressed(_ sender: UIButton) {
        
        delegate?.didSelectMoreButton(self, book: currentBook)
    }
    
    private func setUpImageViewConstraints() {
        addSubview(bookImage)
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            bookImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bookImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60),
            bookImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40)
        ])
    }
    
    private func setUpBestSellerLengthLabelConstraints() {
        addSubview(bestSellerLengthLabel)
        bestSellerLengthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bestSellerLengthLabel.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 5),
            bestSellerLengthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            bestSellerLengthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            bestSellerLengthLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
        ])
    }
    
    private func setUpAbstractLabelConstraints() {
        addSubview(abstractTextView)
        abstractTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            abstractTextView.topAnchor.constraint(equalTo: bestSellerLengthLabel.bottomAnchor, constant: 2),
            abstractTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            abstractTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            abstractTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    private func setupMoreButtonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            moreButton.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 45),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -45)
        ])
    }
    
    public func configureCell(for savedBook: Book) {
        currentBook = savedBook
        //TODO: add label and textviewe
        bestSellerLengthLabel.text = "\(savedBook.weeksOnList) weeks on BestSeller List"
        abstractTextView.text = savedBook.description
        bookImage.getImage(with: savedBook.bookImage) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.bookImage.image = UIImage(systemName: "exclamationmark - octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.bookImage.image = image
                }
            }
        }
    }
}

