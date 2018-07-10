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
        case .cancelled, .ended:
            transformGridView(gesture: sender)
            let imageCreated = app.createImage(from: gridView)
            let activityViewController = UIActivityViewController(activityItems: [imageCreated], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
            completionHandler(for: activityViewController)
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
    
    @IBAction func didTapGridButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        buttonTag = sender.tag
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func transformGridView(gesture: UISwipeGestureRecognizer) {
        let screenHeigth = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let translationTransform: CGAffineTransform
        let deviceOrientation = UIDevice.current.orientation
        if deviceOrientation.isPortrait {
            translationTransform = CGAffineTransform(translationX: 0, y: -screenHeigth)
        } else {
            translationTransform = CGAffineTransform(translationX: -screenWidth, y: 0)
        }
        UIView.animate(withDuration: 0.8, animations: {
            self.gridView.transform = translationTransform
        }) { (success) in
            if success {
                self.gridView.transform = CGAffineTransform(scaleX: 0, y: 0)
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
    
    private func completionHandler(for activityViewController: UIActivityViewController) {
        activityViewController.completionWithItemsHandler = { activity, completed, items, error in
            if !completed {
                // handle task not completed
                // Add label to inform that share operation hasn't done
                self.gridView.transform = .identity
                return
            }
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.gridView.transform = .identity
            }, completion:nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        app.checkPermission()
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            gridView.setImage(pickedImage: pickedImage, buttonTag: buttonTag)
        }
        dismiss(animated: true, completion: nil)
    }
}

