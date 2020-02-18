//
//  NYTBestSellersController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit


import DataPersistence

class NYTBestSellersController: UIViewController {
    
    let dataPersistance:DataPersistence<Book>
    let nytbsView = NYTBestSellersView()
    lazy var collectionView = nytbsView.collectionView
    lazy var pickerView = nytbsView.pickerView
    
    private var bestSellersBooks = [Book](){
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

    }
    
    private var userPref:UserPreference
    
    private var topics = [BookTopic]() {
        didSet {
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
                self.pickerView.selectRow(self.userPref.getSectionIndex() ?? 7, inComponent: 0, animated: true)
            }
        }
    }
    
    init(_ dataPersistence: DataPersistence<Book>, _ userPref: UserPreference) {
        self.dataPersistance = dataPersistence
        self.userPref = userPref
        //self.topics = topics
        super.init(nibName: nil, bundle: nil)
        self.userPref.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = nytbsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nytbsView.backgroundColor = .systemGroupedBackground
        delegatesAndDataSources()
        loadTopics()
        //loadBooks(from: topics[self.userPref.getSectionIndex() ?? 7])
        navigationItem.title = "NYT Bestsellers"
        collectionView.register(NYTBestSellersCell.self, forCellWithReuseIdentifier: "bestSellersCell")
    }
    
    private func delegatesAndDataSources(){
        collectionView.dataSource = self
        collectionView.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func loadTopics(){
        NYTApiClient.getTopics {[weak self] (result) in
            switch result {
            case .failure(let appError):
                self?.showAlert(title: "Failed to get topics", message: "\(appError)")
            case .success(let topics):
                self?.topics = topics
                self?.loadBooks(from: topics[self?.userPref.getSectionIndex() ?? 7])
            }
        }
    }
    
    private func loadBooks(from topic: BookTopic){
        NYTApiClient.getBooks(from: topic) {[weak self] (result) in
            switch result{
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to load books", message: "\(appError)")
                }
            case .success(let books):
                self?.bestSellersBooks = books
            }
        }
    }
}

extension NYTBestSellersController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestSellersBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bestSellersCell", for: indexPath) as? NYTBestSellersCell else { fatalError("failed to downcast to WeatherDayCell. Check resuse ID") }
        let book = bestSellersBooks[indexPath.row]
        cell.configureCell(for: book)
        return cell
    }
    
}

extension NYTBestSellersController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize:CGSize = UIScreen.main.bounds.size
        let itemWidth:CGFloat = maxSize.width * 0.6
        return CGSize(width: itemWidth, height: collectionView.bounds.size.height * 0.9)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBook = bestSellersBooks[indexPath.row]
        let detailVC = BookDetailViewController(dataPersistance, selectedBook)
//        detailVC.passedBook = selectedBook
//        detailVC.dataPersistance = dataPersistance
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension NYTBestSellersController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
}

extension NYTBestSellersController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row].listname
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedTopic = topics[row]
        loadBooks(from: selectedTopic)
    }

}

extension NYTBestSellersController: UserPreferenceDelegate{
    func didChangeBooksSection(_ userPreference: UserPreference, sectionIndex: Int) {
        DispatchQueue.main.async {
            self.pickerView.selectRow(sectionIndex, inComponent: 0, animated: true)
            self.loadBooks(from: self.topics[sectionIndex])
        }
    }
}
