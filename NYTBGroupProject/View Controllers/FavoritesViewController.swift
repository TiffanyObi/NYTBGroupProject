//
//  FavoritesViewController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private let favoriteView = FavoritesView()
    
    override func loadView() {
        view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteView.backgroundColor = .systemBackground
        navigationItem.title = "Favorites(0)"
        favoriteView.collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "favoritesCell")
        favoriteView.collectionView.dataSource = self
        favoriteView.collectionView.delegate = self

    }
    


}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath)
        
        return cell
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
}
