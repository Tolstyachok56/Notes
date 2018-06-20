//
//  TagViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 20.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var nameTextField: UITextField!
    
    //MARK: -
    
    var tag: Tag?
    
    //MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Edit Tag"
        
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewWillDisappear(animated)
        
        if let name = nameTextField.text, !name.isEmpty {
            tag?.name = name
        }
    }
    
    //MARK: -  View methods
    
    private func setupView() {
        setupNameTextField()
    }
    
    private func setupNameTextField() {
        nameTextField.text = tag?.name
    }

}
