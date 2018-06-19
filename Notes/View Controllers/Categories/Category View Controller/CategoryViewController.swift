//
//  CategoryViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var nameTextField: UITextField!
    
    //MARK: -
    
    var category: Category?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Category"
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let name = nameTextField.text, !name.isEmpty {
            category?.name = name
        }
    }
    
    //MARK: - View methods
    
    private func setupView() {
        setupNameTextField()
    }
    
    private func setupNameTextField() {
        nameTextField.text = category?.name
    }
    
    


}
