//
//  BookDetailView.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import DataPersistence




class BookDetailView: UIView {
    
   
    
    public lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "queenOfHearts")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds =  true
        return imageView
    }()
    
    public lazy var bookNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Queen Of Hearts"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Didot", size: 23.0)
        return label
    }()
    
    
    public lazy var summaryTextView: UITextView = {
        let textView = UITextView()
        textView.text = " UIButton or Segmented control There should be 4 buttons or 4 segemented control that would take you to a safari view controller to present the book sellers webpage,Safari ViewController It should show Amazon, apple books, Barnes & Nobles, Local Book Sellers based on one of the 4 buttons selected,The Detail ViewController should show the Book's image (Large image), a TextView for the description and a label for the book title and a Favorite button.Favorites Button When a user favorites a book there should be a show alert or animation (It's up to you) anything that shows the user the book they favrited was added "
        textView.font = UIFont(name: "Didot", size: 20.0)
        textView.isSelectable = false
        textView.backgroundColor = .white
      return textView
    }()
    
    private lazy var amazonButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "amazon"), for: .normal)
        button.tag = 0
//        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        return button
    }()
    private lazy var barnesAndNoblesButton: UIButton = {
        let button = UIButton()
       button.setImage(UIImage(named: "applebook"), for: .normal)
        button.tag = 1
//        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var appleBooksButton: UIButton = {
           let button = UIButton()
           button.setImage(UIImage(named: "barnesandnoble"), for: .normal)
        button.tag = 2
//        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
           return button
       }()
    private lazy var localBooksellersButton: UIButton = {
           let button = UIButton()
       button.setImage(UIImage(named: "localbookstores"), for: .normal)
        button.tag = 3
//        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
           return button
       }()
    
    
    
    public lazy var allButtons: [UIButton] = {
        let buttons = [amazonButton,barnesAndNoblesButton,appleBooksButton,
        localBooksellersButton]
        
        return buttons
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.backgroundColor = .yellow
        return stackView
    }()
    

        
        override init(frame: CGRect) {
            super.init(frame:UIScreen.main.bounds)
            commomInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder:coder)
            commomInit()
        }
        
        private func commomInit() {
            setUpBookImageViewConstraints()
            setUpBookNameLabelCnstraints()
            setUpSummaryTextViewConstraints()
            setUpStackViewConstraints()
            
        }
    
    private func setUpBookImageViewConstraints() {
        addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
        
            bookImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            bookImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            bookImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
        
        
        ])
    }
    
    private func setUpBookNameLabelCnstraints() {
        addSubview(bookNameLabel)
        bookNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookNameLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 5),
            bookNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            bookNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)

        ])
    }
    
    private func setUpSummaryTextViewConstraints() {
        addSubview(summaryTextView)
        summaryTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            summaryTextView.topAnchor.constraint(equalTo: bookNameLabel.bottomAnchor, constant: 40),
            summaryTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            summaryTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            summaryTextView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15)
        
        
        
        ])
    }
    
    private func setUpStackViewConstraints() {
        addSubview(stackView)
        stackView.addArrangedSubview(amazonButton)
        stackView.addArrangedSubview(barnesAndNoblesButton)
        stackView.addArrangedSubview(appleBooksButton)
        stackView.addArrangedSubview(localBooksellersButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints =  false
        
        NSLayoutConstraint.activate([
        
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.04)
        
        ])
    }
    
    
   
    
    
}


