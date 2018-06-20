//
//  TagTableViewCell.swift
//  Notes
//
//  Created by Виктория Бадисова on 20.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell {

    //MARK: - Static properties
    
    static let reuseIdentifier = "TagTableViewCell"
    
    //MARK: - Properties
    
    @IBOutlet var nameLabel: UILabel!
    
    //MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
