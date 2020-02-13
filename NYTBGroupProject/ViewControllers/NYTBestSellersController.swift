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
    
    private var topics = [BookTopic]()
    
    init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistance = dataPersistence
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = nytbsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatesAndDataSources()
        loadTopics()
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
                //TODO: ADD SHOW ALERT
                break
            case .success(let topics):
                self?.topics = topics
            }
        }
    }
    
    private func loadBooks(from topic: BookTopic){
        NYTApiClient.getBooks(from: topic) {[weak self] (result) in
            switch result{
            case .failure(let appError):
                //TODO: ADD SHOW ALERT
                break
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherDayCell", for: indexPath) as? NYTBestSellersCell else { fatalError("failed to downcast to WeatherDayCell. Check resuse ID") }
        let book = bestSellersBooks[indexPath.row]
        cell.configureCell(for: book)
        return cell
    }
    
}

extension NYTBestSellersController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize:CGSize = UIScreen.main.bounds.size
        let itemWidth:CGFloat = maxSize.width * 0.4
        return CGSize(width: itemWidth, height: itemWidth*1.5)
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
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return topics.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedTopic = topics[row]
        loadBooks(from: selectedTopic)
    }
}

extension NYTBestSellersController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return topics[row].listname
    }

}
