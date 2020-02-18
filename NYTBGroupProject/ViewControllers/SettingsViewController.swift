//
//  SettingsViewController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    private var settingView = SettingView()
    private var bookTopics = [BookTopic](){
        didSet{
            DispatchQueue.main.async {
            
    self.settingView.settingsPickerView.reloadAllComponents()
        }
    }
}
    private var userPref:UserPreference
    
    init(_ userPref: UserPreference) {
        self.userPref = userPref
        //self.bookTopics = bookTopics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = settingView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getTopics()
        settingView.settingsPickerView.dataSource = self
        settingView.settingsPickerView.delegate = self
        navigationItem.title = "Pick A Catagory"
       
//        let loadedTopicIndex = userPref.getSectionIndex()
//        settingView.settingsPickerView.selectedRow(inComponent: loadedTopicIndex ?? 0)
    }
    
    
    
    private func getTopics() {

        NYTApiClient.getTopics { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Could not get Topics\(appError)")
                }
            case .success(let topics):
                print(topics.count)
                print(topics[0].listname)
                self?.bookTopics = topics
                DispatchQueue.main.async {
                    self?.settingView.settingsPickerView.selectRow(self?.userPref.getSectionIndex() ?? 0, inComponent: 0, animated: true)
                }
            }
        }
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return bookTopics.count
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = bookTopics[row].listname
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let sortedTopics = bookTopics.sorted{$0.listname < $1.listname}
        return bookTopics[row].listname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        userPref.setSectionIndex(row)
        
    }

}
