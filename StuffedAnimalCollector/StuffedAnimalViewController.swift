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
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var animal : StuffedAnimal? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if animal != nil {
            animalImageView.image = UIImage(data: animal!.image! as Data)
            stuffedAnimalTextField.text = animal!.name
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
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
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }

    @IBAction func addTapped(_ sender: Any) {
        
        if animal != nil {
            animal!.name = stuffedAnimalTextField.text
            animal!.image = UIImagePNGRepresentation(animalImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let stuffedAnimal = StuffedAnimal(context: context)
            
            stuffedAnimal.name = stuffedAnimalTextField.text
            stuffedAnimal.image = UIImagePNGRepresentation(animalImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(animal!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
    }
}
