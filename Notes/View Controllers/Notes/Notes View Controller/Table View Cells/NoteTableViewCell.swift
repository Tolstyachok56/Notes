//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    //MARK: - Static properties
    
    static let reuseIdentifier = "NoteTableViewCell"
    
    //MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var updatedAtLabel: UILabel!
    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
