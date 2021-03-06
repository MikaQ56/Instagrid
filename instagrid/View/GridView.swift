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
    
    var layout: Grid = .grid1 {
        didSet {
            setLayout(layout)
        }
    }
    
    // When user picked an image from photo library, then this one is set. 
    func setImage(pickedImage: UIImage, buttonTag: Int) {
        let button = buttonTapped(is: buttonTag)
        button.setImage(pickedImage, for: UIControlState.normal)
    }
    
    // Squares and rectangles are hidden depending the grid layout
    private func setLayout(_ layout: Grid) {
        initialGridScale()
        switch layout {
        case .grid1:
            animateGrid1()
        case .grid2:
            animateGrid2()
        case .grid3:
            animateGrid3()
        }
    }
    
    private func initialGridScale() {
        square1.transform = CGAffineTransform(scaleX: 1, y: 0)
        square2.transform = CGAffineTransform(scaleX: 1, y: 0)
        square3.transform = CGAffineTransform(scaleX: 1, y: 0)
        square4.transform = CGAffineTransform(scaleX: 1, y: 0)
        rectangle1.transform = CGAffineTransform(scaleX: 0, y: 1)
        rectangle2.transform = CGAffineTransform(scaleX: 0, y: 1)
    }
    
    private func animateGrid1() {
        UIView.animate(withDuration: 0.4) {
            self.square3.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.square4.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.rectangle1.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func animateGrid2(){
        UIView.animate(withDuration: 0.4) {
            self.square1.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.square2.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.rectangle2.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    private func animateGrid3() {
        UIView.animate(withDuration: 0.4) {
            self.square1.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.square2.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.square3.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        UIView.animate(withDuration: 0.4) {
            self.square4.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    func pickedImageAnimation(buttonTag: Int) {
        let button = buttonTapped(is: buttonTag)
        button.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.7, options: [], animations: {
            button.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion:nil)
    }
    
    private func buttonTapped(is buttonTag: Int) -> UIButton {
        var button =  UIButton()
        switch buttonTag {
        case 1:
            button = square1
        case 2:
            button = square2
        case 3:
            button = square3
        case 4:
            button = square4
        case 5:
            button = rectangle1
        case 6:
            button = rectangle2
        default:
            break
        }
        return button
    }
}
