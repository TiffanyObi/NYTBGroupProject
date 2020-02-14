//
//  UserDefaults.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/13/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//


import Foundation

struct UserKey {
    static let sectionName = "Book Section"
    static let sectionIndex = "Book Section Index"
}

protocol UserPreferenceDelegate: AnyObject {
    func didChangeBooksSection(_ userPreference: UserPreference, sectionIndex: Int)
}

final class UserPreference {
    weak var delegate: UserPreferenceDelegate?
    
    public func getSectionIndex() -> Int?{
        return UserDefaults.standard.object(forKey: UserKey.sectionIndex) as? Int
    }
    
    public func setSectionIndex(_ section: Int){
        UserDefaults.standard.set(section, forKey: UserKey.sectionIndex)
            delegate?.didChangeBooksSection(self, sectionIndex: section)

    }
}
