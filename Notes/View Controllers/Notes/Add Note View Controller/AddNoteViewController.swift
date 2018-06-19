//
//  AddNoteViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 18.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    //MARK: -
    
    var managedObjectContext: NSManagedObjectContext?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add Note"
    }

    //MARK: - Actions
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        
        guard let managedObjectContext = managedObjectContext else { return }
        
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(withTitle: "Title missing", andMessage: "Your note doesn't have a title.")
            return
        }
        
        let note = Note(context: managedObjectContext)
        
        note.title = title
        note.contents = contentsTextView.text
        note.createdAt = Date()
        note.updatedAt = Date()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
}
