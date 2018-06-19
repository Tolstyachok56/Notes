//
//  NotesViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 15.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Segues
    
    private enum Segue {
        static let AddNote = "AddNote"
        static let Note = "Note"
    }
    
    //MARK: - Properties
    
    @IBOutlet var notesView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //MARK: -
    
    var coreDataManager = CoreDataManager(modelName: "Notes")
    
    //MARK: -
    
    private var notes: [Note]? {
        didSet {
            updateView()
        }
    }
    
    //MARK: -
    
    private var hasNotes: Bool {
        guard let notes = notes else { return false }
        return notes.count > 0
    }
    
    //MARK: -
    
    private lazy var updatedAtDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, HH:mm"
        return dateFormatter
    }()
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        setupView()
        fetchNotes()
        setupNotificationHandling()
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.AddNote:
            guard let destination = segue.destination as? AddNoteViewController else { return }
            destination.managedObjectContext = coreDataManager.managedObjectContext
        case Segue.Note:
            guard let destination = segue.destination as? NoteViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow, let note = notes?[indexPath.row] else { return }
            destination.note = note
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    //MARK: - View methods
    
    private func setupView() {
        setupMessageLabel()
        setupTableView()
    }
    
    private func updateView() {
        tableView.isHidden = !hasNotes
        messageLabel.isHidden = hasNotes
    }
    
    private func setupMessageLabel() {
        messageLabel.text = "You don't have any notes yet"
    }
    
    private func setupTableView() {
        
    }
    
    //MARK: - Fetching
    
    private func fetchNotes() {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Note.updatedAt), ascending: false)]
        
        coreDataManager.managedObjectContext.performAndWait {
            do {
                let notes = try fetchRequest.execute()
                self.notes = notes
                self.tableView.reloadData()
            } catch let fetchError {
                print("Unable to execute fetch request")
                print("\(fetchError): \(fetchError.localizedDescription)")
            }
        }
    }
    
    //MARK: - UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return hasNotes ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let notes = notes else { return 0 }
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let note = notes?[indexPath.row] else {
            fatalError("Unexpected index path")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.reuseIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("Unexpected index path")
        }
        
        cell.titleLabel.text = note.title
        cell.contentsLabel.text = note.contents
        cell.updatedAtLabel.text = updatedAtDateFormatter.string(from: note.updatedAt!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        guard let note = notes?[indexPath.row] else { fatalError("Unexpected index path")}
        
        note.managedObjectContext?.delete(note)
    }
    
    //MARK: - Helper methods
    
    private func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(managedObjectContextObjectsDidChange(_:)), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: coreDataManager.managedObjectContext)
    }
    
    //MARK: - Notification handling
    
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        var notesDidChange = false
        
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> {
            for insert in inserts {
                if let note = insert as? Note {
                    notes?.append(note)
                    notesDidChange = true
                }
            }
        }
        
        if let updates = userInfo[NSUpdatedObjectsKey] as? Set<NSManagedObject> {
            for update in updates {
                if let _ = update as? Note {
                    notesDidChange = true
                }
            }
        }
        
        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject> {
            for delete in deletes {
                if let note = delete as? Note {
                    if let index = notes?.index(of: note) {
                        notes?.remove(at: index)
                        notesDidChange = true
                    }
                }
            }
        }
        
        if notesDidChange {
            notes?.sort(by: { $0.updatedAt! > $1.updatedAt!})
            tableView.reloadData()
            updateView()
        }
        
    }


}

