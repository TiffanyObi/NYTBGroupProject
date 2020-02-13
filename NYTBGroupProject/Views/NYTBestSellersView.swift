//
//  NYTBestSellersView.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class NYTBestSellersView: UIView {
    
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray3
        return cv
    }()
    
    lazy var pickerView : UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
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
        setUpCVConstrainsts()
        setUpPVConstrainsts()
    }
    
    private func setUpCVConstrainsts(){
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            collectionView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setUpPVConstrainsts(){
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
                pickerView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
                pickerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
    }


}
