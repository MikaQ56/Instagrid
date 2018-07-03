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
    
    let app = App()
    
    var buttonTag: Int = 0
    
    @IBOutlet var selectedIcons: [UIImageView]!
    
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let directions: [UISwipeGestureRecognizerDirection] = [.up,.left]
        for direction in directions {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGridView(_:)))
            gridView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            gridView.isUserInteractionEnabled = true
        }
        
    }
    
    @objc func swipeGridView(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .began, .changed:
            transformGridView(gesture: sender)
        case .cancelled, .ended:
            let image = app.setImage(from: gridView)
            let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        default:
            break
        }
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
    
    @IBAction func didTapGridButton(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        let button = sender as! UIButton
        buttonTag = button.tag
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func transformGridView(gesture: UISwipeGestureRecognizer) {
        let screenHeigth = UIScreen.main.bounds.height
        print(screenHeigth)
        let screenWidth = UIScreen.main.bounds.width
        print(screenWidth)
        let translationTransform: CGAffineTransform
        if gesture.direction == .up {
            translationTransform = CGAffineTransform(scaleX: 0, y: screenHeigth)
        } else {
            translationTransform = CGAffineTransform(scaleX: screenWidth, y: 0)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.gridView.transform = translationTransform
        }) { (success) in
            if success {
                self.gridView.transform = .identity
            }
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

