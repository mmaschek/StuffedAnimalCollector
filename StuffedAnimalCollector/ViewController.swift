//
//  ViewController.swift
//  StuffedAnimalCollector
//
//  Created by Mike Maschek on 3/3/17.
//  Copyright © 2017 Mike Maschek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var stuffedAnimals : [StuffedAnimal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            try stuffedAnimals = context.fetch(StuffedAnimal.fetchRequest())
            print(stuffedAnimals)
            tableView.reloadData()
        }
        catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stuffedAnimals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let stuffedAnimal = stuffedAnimals[indexPath.row]
        cell.textLabel?.text = stuffedAnimal.name
        cell.imageView?.image = UIImage(data: stuffedAnimal.image! as Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stuffedAnimal = stuffedAnimals[indexPath.row]
        performSegue(withIdentifier: "animalSegue", sender: stuffedAnimal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! StuffedAnimalViewController
        nextVC.animal = sender as? StuffedAnimal
    }

}

