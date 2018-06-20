//
//  TagsViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 20.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit
import CoreData

class TagsViewController: UIViewController {
    
    //MARK: - Segues
    
    private enum Segue {
        static let Tag = "Tag"
        static let AddTag = "AddTag"
    }
    
    //MARK: - Properties
    
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //MARK: -
    
    var note: Note?
    
    //MARK: -
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Tag> = {
        guard let managedObjectContext = self.note?.managedObjectContext else {
            fatalError("No managed object context found")
        }
        
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Tag.name), ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    //MARK: -
    
    var hasTags: Bool {
        guard let managedObjects = fetchedResultsController.fetchedObjects else { return false }
        return managedObjects.count > 0
    }
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tags"
        
        setupView()
        fetchTags()
        updateView()
    }
    
    //MARK: - View methods
    
    private func setupView() {
        setupMesageLabel()
        setupBarButtonItems()
    }
    
    private func setupMesageLabel() {
        messageLabel.text = "You don't have any tags yet"
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
    }
    
    private func updateView() {
        tableView.isHidden = !hasTags
        messageLabel.isHidden = hasTags
    }
    
    //MARK: - Actions
    
    @objc private func add(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: Segue.AddTag, sender: sender)
    }
    
    //MARK: - Fetching
    
    private func fetchTags() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Unable to perform fetch")
            print("\(error): \(error.localizedDescription)")
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.AddTag:
            guard let destination = segue.destination as? AddTagViewController else { return }
            destination.managedObjectContext = note?.managedObjectContext
        case Segue.Tag:
            guard let destination = segue.destination as? TagViewController else { return }
            guard let cell = sender as? TagTableViewCell else { return }
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let tag = fetchedResultsController.object(at: indexPath)
            destination.tag = tag
        default:
            fatalError("Unexpected segue identifier")
        }
    }
    
    // MARK: - Helper methods
    
    private func configure(_ cell: TagTableViewCell, at indexPath: IndexPath) {
        let tag = fetchedResultsController.object(at: indexPath)
        
        cell.nameLabel.text = tag.name

        if let containsTag = note?.tags?.contains(tag), containsTag == true {
            cell.nameLabel.textColor = .bitterSweet
        } else {
            cell.nameLabel.textColor = .black
        }
    }

}

// MARK: - UITableViewDataSource methods

extension TagsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else { return 0 }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TagTableViewCell.reuseIdentifier, for: indexPath) as? TagTableViewCell else {
            fatalError("Unexpected index path")
        }
        
        configure(cell, at: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let tag = fetchedResultsController.object(at: indexPath)
        
        note?.managedObjectContext?.delete(tag)
    }
}

// MARK: - UITableViewDelegate methods

extension TagsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tag = fetchedResultsController.object(at: indexPath)
        
        if let containsTag = note?.tags?.contains(tag), containsTag == true {
            note?.removeFromTags(tag)
        } else {
            note?.addToTags(tag)
        }
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate methods

extension TagsViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath) as? TagTableViewCell {
                configure(cell, at: indexPath)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
}
