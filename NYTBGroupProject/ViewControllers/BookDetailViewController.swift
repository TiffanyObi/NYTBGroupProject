//
//  BookDetailViewController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import SafariServices

class BookDetailViewController: UIViewController {

     private var bookDetailView = BookDetailView()
    
    var url = "" {
        didSet {
            print("testing that the data transfers - \(url)")
        }
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


