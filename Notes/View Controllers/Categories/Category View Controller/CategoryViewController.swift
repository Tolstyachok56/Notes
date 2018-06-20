//
//  CategoryViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - Segues
    
    private enum Segue {
        static let Color = "Color"
    }
    
    //MARK: - Properties
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var colorView: UIView!
    
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
        setupColorView()
    }
    
    private func setupColorView() {
        colorView.layer.cornerRadius = CGFloat(colorView.frame.width / 2.0)
        updateColorView()
    }
    
    private func updateColorView() {
        colorView.backgroundColor = category?.color
    }
    
    private func setupNameTextField() {
        nameTextField.text = category?.name
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.Color:
            guard let destination = segue.destination as? ColorViewController else { return }
            destination.delegate = self
            destination.color = category?.color ?? .white
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
}

//MARK: - ColorViewControllerDelegate methods

extension CategoryViewController: ColorViewControllerDelegate {
    func controller(_ controller: ColorViewController, didPick color: UIColor) {
        category?.color = color
        updateColorView()
    }
    
    
}
