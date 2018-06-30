//
//  ViewController.swift
//  instagrid
//
//  Created by Mickael on 29/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet var selectedIcons: [UIImageView]!
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapLayout1Button() {
        displaySelectedIcon(at: 0)
        gridView.layout = .grid1
    }
    
    @IBAction func didTapLayout2Button() {
        displaySelectedIcon(at: 1)
        gridView.layout = .grid2
    }
    
    @IBAction func didTapLayout3Button() {
        displaySelectedIcon(at: 2)
        gridView.layout = .grid3
    }
    
    private func displaySelectedIcon(at position: Int) {
        for (index, icon) in selectedIcons.enumerated() {
            if index == position {
                icon.isHidden = false
            } else {
                icon.isHidden = true
            }
        }
    }
}

