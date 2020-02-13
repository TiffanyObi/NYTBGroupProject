//
//  NYTTabController.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit
import DataPersistence

class NYTTabController: UITabBarController {
    
    private let dataPersistence = DataPersistence<Book>(filename: "SavedNYTBestSellers")
    private let userPref: UserPreference!
    lazy var nytBestSellersVC:NYTBestSellersController = {
        let vc = NYTBestSellersController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Best Sellers", image: UIImage(systemName: "eyeglasses"), tag: 0)
        return vc
    }()
    
    lazy var nytFavoritesVC:FavoritesViewController = {
        let vc = FavoritesViewController(dataPersistence)
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        return vc
    }()
    
    lazy var nytSettingsVC:SettingsViewController = {
        let vc = SettingsViewController(userPref)
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "pencil"), tag: 0)
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let controllers = [nytBestSellersVC, nytFavoritesVC, nytSettingsVC]
        viewControllers = controllers.map{UINavigationController(rootViewController: $0)}
    }
}
