//
//  GridImage.swift
//  instagrid
//
//  Created by Mickael on 13/07/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation

// Image of type GridImage
class GridImage {
    
    // Image URL
    private var url: NSURL
    // Button associated to image
    var buttonTag: Int
    
    init(url: NSURL, buttonTag: Int) {
        self.url = url
        self.buttonTag = buttonTag
    }
}
