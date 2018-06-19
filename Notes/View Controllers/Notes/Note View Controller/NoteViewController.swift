//
//  NoteViewController.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentsTextView: UITextView!
    
    //MARK: -
    
    var note: Note?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Note"
        
        setupView()
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
    }
    
    private func setupTextField() {
        titleTextField.text = note?.title
    }
    
    private func setupTextView() {
        contentsTextView.text = note?.contents
    }
    
}
