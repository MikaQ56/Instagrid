//
//  Share.swift
//  instagrid
//
//  Created by Mickael on 03/07/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation
import UIKit

class App {
    
    func setImage(from view: GridView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
}




