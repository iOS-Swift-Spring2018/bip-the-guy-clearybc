//
//  ViewController.swift
//  Hug the Person
//
//  Created by Barbara on 2/11/18.
//  Copyright © 2018 Barbara. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var audioPlayer = AVAudioPlayer()
    var imagePicker = UIImagePickerController()
    
    //MARK: Outlets
    @IBOutlet weak var imageToHug: UIImageView!
    
    //MARK: Functions
    
    func animateImage(){
        let bounds = self.imageToHug.bounds
        let shrinkValue: CGFloat = 60
        //shrink image by 60
        self.imageToHug.bounds = CGRect(x: self.imageToHug.bounds.origin.x + shrinkValue , y: self.imageToHug.bounds.origin.y + shrinkValue, width: self.imageToHug.bounds.size.width - shrinkValue, height: self.imageToHug.bounds.height - shrinkValue)
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: [], animations: { self.imageToHug.bounds = bounds }, completion: nil)
    }
    
    
    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        // Can we load in the file soundName?
        if let sound = NSDataAsset(name: soundName) {
            // check if sound.data is a sound file
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                // if sound.data is not a valid audio file
                print("ERROR: data in \(soundName) couldn't be played as a sound.")
            }
        } else {
            // if reading in the NSDataAsset didn't work, tell the user / report the error.
            print("ERROR: file \(soundName) didn't load")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageToHug.image = selectedImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: Actions

    @IBAction func libraryPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraPressed(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        
        imagePicker.sourceType = .camera
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
        else{
            showAlert(title: "Oh no!", message: "You don't have a camera")
            
        }}
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "wooshSound", audioPlayer: &audioPlayer)
    }
    
    
    @IBAction func imageGesture(_ sender: UITapGestureRecognizer) {
        animateImage()
        playSound(soundName: "wooshSound", audioPlayer: &audioPlayer)
        
    }
    }

