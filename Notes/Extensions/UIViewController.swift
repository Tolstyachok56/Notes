//
//  UIViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 18.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
