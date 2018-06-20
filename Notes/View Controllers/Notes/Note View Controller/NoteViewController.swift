//
//  NoteViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    //MARK: - Segues
    
    private enum Segue {
        static let Categories = "Categories"
    }
    
    //MARK: - Properties
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    @IBOutlet var categoryLabel: UILabel!
    
    
    //MARK: -
    
    var note: Note?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Note"
        
        setupView()
        setupNotificationHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let title = titleTextField.text, !title.isEmpty {
            note?.title = title
        }
        
        note?.updatedAt = Date()
        note?.contents = contentsTextView.text
    }
    
    //MARK: - View methods
    
    private func setupView() {
        setupTextField()
        setupTextView()
        updateCategoryLabel()
    }
    
    private func setupTextField() {
        titleTextField.text = note?.title
    }
    
    private func setupTextView() {
        contentsTextView.text = note?.contents
    }
    
    private func updateCategoryLabel() {
        categoryLabel.text = note?.category?.name ?? "No category"
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.Categories:
            guard let destination = segue.destination as? CategoriesViewController else { return }
            destination.note = note
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    //MARK: - Helper methods
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: note?.managedObjectContext)
    }
    
    //MARK: - Notification handling
    
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        guard let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> else { return }
        
        if (updates.filter{ $0 == note}).count > 0 {
            updateCategoryLabel()
        }
    }
    
}
