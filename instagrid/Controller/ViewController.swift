//
//  ViewController.swift
//  instagrid
//
//  Created by Mickael on 29/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var selectedIcon: [UIImageView]!
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func didTapLayout1() {
        selectedIcon[1].isHidden = false
        gridView.layout = .grid1
    }
    
    @IBAction func didTapLayout2() {
        selectedIcon[2].isHidden = false
        gridView.layout = .grid2
    }
    
    @IBAction func didTapLayout3() {
        selectedIcon[0].isHidden = false
        gridView.layout = .grid3
    }
}

