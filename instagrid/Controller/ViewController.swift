//
//  ViewController.swift
//  instagrid
//
//  Created by Mickael on 29/06/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Image Picker Controller initialized
    private let imagePicker = UIImagePickerController()
    
    // App model initialized
    private let app = App()
    
    // buttonTag property permits to identify what button is tapped ?
    private var buttonTag: Int = 0
    
    @IBOutlet var selectedIcons: [UIImageView]!
    
    @IBOutlet var gridView: GridView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridView.layout = .grid1
        displaySelectedIcon(from: 0)
        imagePicker.delegate = self
        // Swipe directions available in app
        let directions: [UISwipeGestureRecognizerDirection] = [.up,.left]
        // Swipe gesture added to app
        for direction in directions {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGridView(_:)))
            gridView.addGestureRecognizer(swipeGesture)
            swipeGesture.direction = direction
            gridView.isUserInteractionEnabled = true
        }
    }
    
    // Method called when swipe gesture occured
    @objc func swipeGridView(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .cancelled, .ended:
            // GridView animation with the swipe gesture
            transformGridView(gesture: sender)
            // Create an image file from the gridview to share
            let imageCreated = createImage(from: gridView)
            // Initialiez the activity view controller
            let activityViewController = UIActivityViewController(activityItems: [imageCreated], applicationActivities: nil)
            // Display the activity view controller
            present(activityViewController, animated: true, completion: nil)
            // Completion handler for activity view controller
            completionHandler(for: activityViewController)
        default:
            break
        }
    }
    
    // Connect action user when he taps on layout's buttons
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
    
    // Connect action user when he taps on grid's buttons (squares & rectangles)
    @IBAction func didTapGridButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        // Identified the grid button tapped with its tag
        buttonTag = sender.tag
        // Display image picker view
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Animation for swipe gesture on grid view
    private func transformGridView(gesture: UISwipeGestureRecognizer) {
        let screenHeigth = UIScreen.main.bounds.height
        let screenWidth = UIScreen.main.bounds.width
        let translationTransform: CGAffineTransform
        // Check the device orientation
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
    
    // Check if it's necessary to display selected icon image on the layout button
    private func displaySelectedIcon(from buttonTag: Int) {
        for (index, icon) in selectedIcons.enumerated() {
            if index == buttonTag {
                icon.isHidden = false
            } else {
                icon.isHidden = true
            }
        }
    }
    
    // Completion handler for activity view controller
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
    
    // Method called when user picked an image from photo library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Check user's permission to access the photo library
        checkPermission()
        // When user picks an image, then update app model
        if let pickedImageUrl = info[UIImagePickerControllerImageURL] as? NSURL {
            app.saveImage(url: pickedImageUrl, buttonTag: buttonTag)
        }
        // When user picks an image, then update the view
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            gridView.setImage(pickedImage: pickedImage, buttonTag: buttonTag)
        }
        dismiss(animated: true) {
            self.animatePickedImage(buttonTag: self.buttonTag)
        }
    }
    
    private func animatePickedImage(buttonTag: Int) {
        gridView.pickedImageAnimation(buttonTag: buttonTag)
    }
    
    // Create an image from gridView to share
    private func createImage(from view: GridView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    // Check permission's user to library photo
    private func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            print("User do not have access to photo album.")
        case .denied:
            print("User has denied the permission.")
        }
    }
}

