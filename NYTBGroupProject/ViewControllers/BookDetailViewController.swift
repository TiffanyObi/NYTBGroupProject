//
//  BookDetailViewController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import SafariServices
import DataPersistence

class BookDetailViewController: UIViewController {

    private var bookDetailView = BookDetailView()
    
    
    private var dataPersistence: DataPersistence<Book>
    private var selectedBook: Book
    

    init(_ dataPersistence: DataPersistence<Book>, _ selectedBook: Book){
        self.dataPersistence = dataPersistence
        self.selectedBook = selectedBook
        super.init(nibName: nil, bundle: nil)

    }

    required init(coder: NSCoder) {
        fatalError("error")
    }

    
    override func loadView() {
        super.loadView()
        view = bookDetailView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGroupedBackground
        
        for button in bookDetailView.allButtons {
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(favoriteButtonPressed))
        
         updateUI()
    }
    
    @objc func buttonPressed(_ sender: UIButton){
       

        let url = selectedBook.buyLinks[sender.tag].url
        
        let vC = SFSafariViewController(url: URL(string: url)!)
           present(vC,animated: true)
       
       }
   
    
    @objc func favoriteButtonPressed() {
        
        print("button pressed")
        
        if dataPersistence.hasItemBeenSaved(selectedBook) {
            showAlert(title: "Wait!!", message: "This book has already been saved to your favorites")
        } else {
            do {
                try dataPersistence.createItem(selectedBook)
                showAlert(title: "Awesome", message: "Your book has been saved!")
            } catch {
                showAlert(title: "Error", message: "Sorry, we were unable to save this book.")
            }
        }
    }

    private func updateUI() {
        bookDetailView.summaryTextView.text = selectedBook.description
        
        
        bookDetailView.bookImageView.getImage(with: selectedBook.bookImage) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.bookDetailView.bookImageView.image = UIImage(systemName: "exclamationmark-octagon")
                }
            case .success(let image):
                DispatchQueue.main.async {
              
                self?.bookDetailView.bookImageView.image = image
            }
        }
        
    }
        
        bookDetailView.bookNameLabel.text = selectedBook.title

}


}
