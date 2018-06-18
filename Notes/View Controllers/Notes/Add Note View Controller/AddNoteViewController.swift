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
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    var managedObjectContext: NSManagedObjectContext?

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
