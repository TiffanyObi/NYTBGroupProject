//
//  ShowAlert.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/13/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, completion: ((UIAlertAction) ->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: completion)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

