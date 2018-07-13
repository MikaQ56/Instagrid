//
//  GridView.swift
//  instagrid
//
//  Created by Mickael on 30/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

// @IBDesignable attribute added to set up shadows and border with Interface Builder. More details in 'ToolBelt' swift file ('supporting files' folder)
@IBDesignable
class GridView: UIView {
    
    // 4 squares and 2 rectangles compose the GridView
    @IBOutlet private var square1: UIButton!
    @IBOutlet private var square2: UIButton!
    @IBOutlet private var square3: UIButton!
    @IBOutlet private var square4: UIButton!
    @IBOutlet private var rectangle1: UIButton!
    @IBOutlet private var rectangle2: UIButton!
    
    // There is 3 possible grids
    enum Grid {
        case grid1, grid2, grid3
    }
    
    private func defaultGrid() {
        square1.transform = CGAffineTransform(scaleX: 0, y: 0)
        square2.transform = CGAffineTransform(scaleX: 0, y: 0)
        square3.transform = CGAffineTransform(scaleX: 0, y: 0)
        square4.transform = CGAffineTransform(scaleX: 0, y: 0)
        rectangle1.transform = CGAffineTransform(scaleX: 0, y: 0)
        rectangle2.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    var layout: Grid = .grid1 {
        didSet {
            setLayout(layout)
        }
    }
    
    // When user picked an image from photo library, then this one is set. 
    func setImage(pickedImage: UIImage, buttonTag: Int) {
        switch buttonTag {
        case 1:
            square1.setImage(pickedImage, for: UIControlState.normal)
        case 2:
            square2.setImage(pickedImage, for: UIControlState.normal)
        case 3:
            square3.setImage(pickedImage, for: UIControlState.normal)
        case 4:
            square4.setImage(pickedImage, for: UIControlState.normal)
        case 5:
            rectangle1.setImage(pickedImage, for: UIControlState.normal)
        case 6:
            rectangle2.setImage(pickedImage, for: UIControlState.normal)
        default:
            break
        }
        
    }
    
    // Squares and rectangles are hidden depending the grid layout
    private func setLayout(_ layout: Grid) {
        switch layout {
        case .grid1:
            square1.isHidden = true
            square2.isHidden = true
            square3.isHidden = false
            square4.isHidden = false
            rectangle1.isHidden = false
            rectangle2.isHidden = true
        case .grid2:
            square1.isHidden = false
            square2.isHidden = false
            square3.isHidden = true
            square4.isHidden = true
            rectangle1.isHidden = true
            rectangle2.isHidden = false
        case .grid3:
            square1.isHidden = false
            square2.isHidden = false
            square3.isHidden = false
            square4.isHidden = false
            rectangle1.isHidden = true
            rectangle2.isHidden = true
        }
    }
}
