//
//  NotesViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 15.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    //MARK: - Segues
    
    private enum Segue {
        static let AddNote = "AddNote"
    }
    
    //MARK: - Properties
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //MARK: -
    
    var coreDataManager = CoreDataManager(modelName: "Notes")
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = "You don't have any notes yet"
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.AddNote:
            guard let destination = segue.destination as? AddNoteViewController else { return }
            destination.managedObjectContext = coreDataManager.managedObjectContext
        default:
            fatalError("Unexpected segue identifier")
        }
    }

}

