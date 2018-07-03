//
//  ViewController.swift
//  instagrid
//
//  Created by Mickael on 29/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePicker = UIImagePickerController()
    
    var buttonTag: Int = 0
    
    @IBAction func didTapGridButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        let button = sender as! UIButton
        buttonTag = button.tag
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBOutlet var selectedIcons: [UIImageView]!
    
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func didTapLayoutButton(_ sender: UIButton) {
        buttonTag = sender.tag
        displaySelectedIcon(from: buttonTag)
        switch buttonTag {
        case 0:
           gridView.layout = .grid1
        case 1:
            gridView.layout = .grid2
        case 2:
            gridView.layout = .grid3
        default:
            break
        }
        
    }
    
    private func displaySelectedIcon(from buttonTag: Int) {
        for (index, icon) in selectedIcons.enumerated() {
            if index == buttonTag {
                icon.isHidden = false
            } else {
                icon.isHidden = true
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            gridView.setImage(pickedImage: pickedImage, buttonTag: buttonTag)
        }
        dismiss(animated: true, completion: nil)
    }
}

