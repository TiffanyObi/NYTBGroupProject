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
    private var bookTopics = [BookTopic]()
    private var userPref:UserPreference
    
    init(_ userPref: UserPreference) {
        self.userPref = userPref
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
        view.backgroundColor = .systemYellow
        let loadedTopicIndex = userPref.getSectionIndex()
        settingView.settingsPickerView.selectedRow(inComponent: loadedTopicIndex!)
    }
    
    private func getTopics() {
        NYTApiClient.getTopics { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Could not get Topics\(appError)")
                }
            case .success(let topic):
                self?.bookTopics = topic
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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return bookTopics[row].listname
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        userPref.setSectionIndex(row)
        print("THIS IS JUST A TEST PLEASE DELETE AFTER")
    }

}
