//
//  NYTBestSellersCell.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import ImageKit

class NYTBestSellersCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var headLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        addImageViewConstrainsts()
        addHeadLabelConstrainsts()
        addSubLabelConstrainsts()
    }
    
    private func addImageViewConstrainsts(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func addHeadLabelConstrainsts(){
        addSubview(headLabel)
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 8),
            headLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 8),
            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func addSubLabelConstrainsts(){
        addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subLabel.topAnchor.constraint(greaterThanOrEqualTo: headLabel.bottomAnchor, constant: 8),
            subLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subLabel.centerYAnchor.constraint(equalTo: headLabel.centerYAnchor, constant: 8),
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    func configureCell(for book: Book){
        imageView.getImage(with: book.bookImage) { (result) in
            switch result{
            case .failure:
                self.imageView.image = UIImage(systemName: "")
            case .success(let image):
                let deviceBounds = UIScreen.main.bounds.size
                let width = deviceBounds.width * 0.4
                let height = width * 2
                DispatchQueue.main.async {
                    self.imageView.image = image.resizeImage(to: width, height: height)
                }
            }
        }
        headLabel.text = book.title
        subLabel.text = book.title
    }
}

extension UIImage {
    func resizeImage(to width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
