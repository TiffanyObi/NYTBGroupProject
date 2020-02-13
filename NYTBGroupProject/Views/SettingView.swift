//
//  SettingView.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class SettingView: UIView {
    
    
    public lazy var settingsPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        
        return pickerView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setUpPickerViewConstraint()
    }
    
    
    private func setUpPickerViewConstraint() {
        addSubview(settingsPickerView)
        settingsPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsPickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsPickerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            settingsPickerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            settingsPickerView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
        
    }
    
}
