//
//  FavoritesViewController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import DataPersistence
import SafariServices

class FavoritesViewController: UIViewController {
    
    private let favoriteView = FavoritesView()
    
    private var dataPersistance: DataPersistence<Book>
    
    private var favoriteBooks = [Book]() {
        didSet {
            favoriteView.collectionView.reloadData()
            //TODO: add EmptyView here
        }
    }
    
    init(_ dataPersistance: DataPersistence<Book>) {
        self.dataPersistance = dataPersistance
        super.init(nibName: nil, bundle: nil)
        
        self.dataPersistance.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coser:) has  not been implemented")
    }
    
    override func loadView() {
        view = favoriteView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteView.backgroundColor = .white
        navigationItem.title = "Favorites(0)"
        favoriteView.collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "favoritesCell")
        favoriteView.collectionView.dataSource = self
        favoriteView.collectionView.delegate = self

    }
    
    private func fetchFavoriteBooks() {
        do {
            favoriteBooks = try dataPersistance.loadItems()
        } catch {
            print("error saving articles \(error)")
        }
    }
    


}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not downcast to FavoriteCell")
        }
        let book = favoriteBooks[indexPath.row]
        cell.backgroundColor = .yellow
        cell.configureCell(for: book)
        cell.delegate = self
        return cell
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.40
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: push detailVC here
    }
}

extension FavoritesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchFavoriteBooks()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        fetchFavoriteBooks()
    }
    
    
}

extension FavoritesViewController: FavoritesCellDelegate {
    func didSelectMoreButton(_ favoritesCell: FavoritesCell, book: Book) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
                // write a delete helper function
                self.deleteBook(book)
            }
        let goToAmazonAction = UIAlertAction(title: "See on Amazon", style: .default) { (alertAction) in
            self.gotoAmazon(book)
        }
            alertController.addAction(goToAmazonAction)
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true)
        }
        
        private func deleteBook(_ book: Book) {
            guard let index = favoriteBooks.firstIndex(of: book) else {
                return
            }
            do {
                // deletes from documents directory
                try dataPersistance.deleteItem(at: index)
            } catch {
                print("error deleting article \(error)")
                
            }
    }
    
    private func gotoAmazon(_ book: Book) {
        guard let url = URL(string: book.buyLinks[0].url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
       // safariVC.delegate = self
    }
    
    
}

extension FavoritesViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
