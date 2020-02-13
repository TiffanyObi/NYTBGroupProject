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
    private var selectedBook:Book
    
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
        
    }

}
