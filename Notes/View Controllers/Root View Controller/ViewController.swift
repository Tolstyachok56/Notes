//
//  ViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 15.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var coreDataManager = CoreDataManager(modelName: "Notes")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let entityDescription = NSEntityDescription.entity(forEntityName: "Note", in: coreDataManager.managedObjectContext) {
            print(entityDescription.name ?? "No name")
            print(entityDescription.properties)
            
            let note = NSManagedObject(entity: entityDescription, insertInto: coreDataManager.managedObjectContext)
            note.setValue("My First Note", forKey: "title")
            note.setValue(NSDate(), forKey: "createdAt")
            note.setValue(NSDate(), forKey: "updatedAt")
            print(note)
            
            do {
                try coreDataManager.managedObjectContext.save()
            } catch {
                print("Unable to save managed object context")
                print("\(error): \(error.localizedDescription)")
            }
        }
        
        let note = Note(context: coreDataManager.managedObjectContext)
        note.title = "My Second Note"
        note.createdAt = Date()
        note.updatedAt = Date()
        
        print(note)

        
    }

}

