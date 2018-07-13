//
//  Share.swift
//  instagrid
//
//  Created by Mickael on 03/07/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation


class App {
    
    // GridImage type's Array. Images picked by user.
    private var images = [GridImage]()
    
    // Save picked image in images property
    func saveImage(url: NSURL, buttonTag: Int) {
        // Initialize GridImage type
        let image = GridImage(url: url, buttonTag: buttonTag)
        // Is there an image with associated button ? If yes, then 'existsImage' method returns Int >= 0
        let index = existsImage(at: buttonTag)
        if index >= 0 {
            images.remove(at: index)
        }
        // Picked image added to images property
        images.append(image)
    }
    
    // Is there already an image with associated button ? If yes, return image index in images property. Else, return -1
    private func existsImage(at buttonTag: Int) -> Int {
        for (index, image) in images.enumerated() {
            if image.buttonTag == buttonTag {
                return index
            }
        }
        return -1
    }
}




