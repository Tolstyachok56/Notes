//
//  NoteTableViewCell.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "NoteTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var updatedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
