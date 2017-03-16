//
//  StuffedAnimalViewController.swift
//  StuffedAnimalCollector
//
//  Created by Mike Maschek on 3/3/17.
//  Copyright © 2017 Mike Maschek. All rights reserved.
//

import UIKit

class StuffedAnimalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var stuffedAnimalTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        animalImageView.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: Any) {
    }

    @IBAction func addTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let stuffedAnimal = StuffedAnimal(context: context)
        
        stuffedAnimal.name = stuffedAnimalTextField.text
        stuffedAnimal.image = UIImagePNGRepresentation(animalImageView.image!) as NSData?
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
}
