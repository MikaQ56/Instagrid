//
//  GridView.swift
//  instagrid
//
//  Created by Mickael on 30/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class GridView: UIView {

    @IBOutlet private var square1: UIButton!
    @IBOutlet private var square2: UIButton!
    @IBOutlet private var square3: UIButton!
    @IBOutlet private var square4: UIButton!
    @IBOutlet private var rectangle1: UIButton!
    @IBOutlet private var rectangle2: UIButton!
    
    enum Grid {
        case grid1, grid2, grid3
    }
    
    var layout: Grid = .grid1 {
        didSet {
            setLayout(layout)
        }
    }
    
    private func setLayout(_ layout: Grid) {
        switch layout {
        case .grid1:
            square1.isHidden = false
            square2.isHidden = false
            square3.isHidden = false
            square4.isHidden = false
            rectangle1.isHidden = true
            rectangle2.isHidden = true
        case .grid2:
            square1.isHidden = false
            square2.isHidden = false
            square3.isHidden = true
            square4.isHidden = true
            rectangle1.isHidden = true
            rectangle2.isHidden = false
        case .grid3:
            square1.isHidden = true
            square2.isHidden = true
            square3.isHidden = false
            square4.isHidden = false
            rectangle1.isHidden = false
            rectangle2.isHidden = true
        }
    }
}