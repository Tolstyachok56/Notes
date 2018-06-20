//
//  CategoryTableViewCell.swift
//  Notes
//
//  Created by Виктория Бадисова on 19.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    //MARK: - Static properties
    
    static let reuseIdentifier = "CategoryTableViewCell"
    
    //MARK: - Properties
    
    @IBOutlet var nameLabel: UILabel!
    
    
    //MARK: - Initializer
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
