//
//  CategoriesViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    //MARK: - Segues
    
    private enum Segue {
        static let AddCategory = "AddCategory"
        static let Category = "Category"
    }
    
    //MARK: - Properties
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //MARK: -
    
    var coreDataManager = CoreDataManager(modelName: "Category")
    
    //MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        setupView()
        fetchCategories()
        updateView()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.AddCategory:
            guard let destination = segue.destination as? AddNoteViewController else { return }
            destination.managedObjectContext = coreDataManager.managedObjectContext
        case Segue.Category:
            guard let destination = segue.destination as? CategoryViewController else { return }
            
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    //MARK: - View methods
    
    private func setupView() {
        setupMesageLabel()
        setupBarButtonItems()
    }
    private func updateView() {
        
    }
    
    private func setupMesageLabel() {
        messageLabel.text = "You don't have any categories yet"
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    }
    
    //MARK: - Actions
    
    @objc private func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segue.AddCategory, sender: self)
    }
    
    //MARK: - Fetching
    
    private func fetchCategories() {
        
    }
    
}
