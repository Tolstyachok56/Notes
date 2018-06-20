//
//  Note.swift
//  Notes
//
//  Created by Виктория Бадисова on 20.06.2018.
//  Copyright © 2018 Виктория Бадисова. All rights reserved.
//

import Foundation

extension Note {
    
    var alphabetizedTags: [Tag]? {
        guard let tags = tags as? Set<Tag> else { return nil }
        return tags.sorted(by: {
            guard let tag0 = $0.name else { return true }
            guard let tag1 = $1.name else { return true }
            return tag0 < tag1
        })
    }
    
    var alphabetizedTagsAsString: String? {
        guard let tags = alphabetizedTags, tags.count > 0 else { return nil }
        
        let names = tags.compactMap{ $0.name }
        return names.joined(separator: ", ")
    }
    
}
