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
    
    
    //MARK: -
    
    var note: Note?
    
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
        
    }
    
    private func updateView() {
        
    }
    
    //MARK: - Fetching
    
    private func fetchTags() {
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case Segue.AddTag:
            guard let destination = segue.destination as? AddTagViewController else { return }
            
        case Segue.Tag:
            guard let destination = segue.destination as? TagViewController else { return }
            
        default:
            fatalError("Unexpected segue identifier")
        }
    }

}
