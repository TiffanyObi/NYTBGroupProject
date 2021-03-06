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
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    lazy var headLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Didot", size: 18)
        label.text = "test"
        label.textAlignment = .center
        return label
    }()
    
    lazy var subLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont(name: "Didot", size: 15)
        label.text = "Test1"
       
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
        self.backgroundColor = .systemBackground
    }
    
    private func addImageViewConstrainsts(){
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6)
        ])
    }
    
    private func addHeadLabelConstrainsts(){
        addSubview(headLabel)
        headLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            headLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
//            headLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
////            headLabel.top.constraint(equalTo: imageView.centerYAnchor, constant: 40),
//            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
//            headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
            
            headLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2),
            headLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            headLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
          headLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05)
            
        ])
    }
    
    private func addSubLabelConstrainsts(){
        addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            subLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor, constant: 2),
//            subLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
////            subLabel.centerYAnchor.constraint(equalTo: headLabel.centerYAnchor, constant: 8),
//            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
//            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
//            subLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            
            subLabel.topAnchor.constraint(equalTo: headLabel.bottomAnchor),
            subLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            subLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8), subLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configureCell(for book: Book){
        imageView.getImage(with: book.bookImage) { (result) in
            switch result{
            case .failure:
                self.imageView.image = UIImage(systemName: "photo")
            case .success(let image):
                let deviceBounds = UIScreen.main.bounds.size
                let width = deviceBounds.width * 0.4
                let height = width * 2
                DispatchQueue.main.async {
                    self.imageView.image = image.resizeImage(to: width, height: height)
                }
            }
        }
        
        if book.weeksOnList == 1 {
           headLabel.text = "\(book.weeksOnList) week on best seller list"
        } else if book.weeksOnList == 0 {
            headLabel.text = "Recently added"
        } else {
        headLabel.text = "\(book.weeksOnList) weeks on best seller list"
        }
        
        //headLabel.text = "\(book.weeksOnList) weeks on bestseller list"
        subLabel.text = book.description
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
