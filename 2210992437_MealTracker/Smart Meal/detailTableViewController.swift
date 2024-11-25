//
//  detailTableViewController.swift
//  Smart Meal
//
//  Created by Uddeshya Singh on 24/11/24.
//

import UIKit

class detailTableViewController: UITableViewController {

    var selectedMeal: Meal?
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var fats: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var recipe: UITextView!
    @IBOutlet weak var protein: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let meal = selectedMeal {
            imgView.image = meal.image
            imgView.layer.cornerRadius = 12
            protein.text = "\(meal.nutrients.proteins) g"
            fats.text = "\(meal.nutrients.fats) g"
            ingredients.text = "\(meal.ingredients)"
            calories.text = "\(meal.nutrients.calories) g"
            carbs.text = "\(meal.nutrients.carbs) g"
            recipe.text = "\(meal.recipe)"
        }
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        if let meal = selectedMeal {
            let activityVC = UIActivityViewController(activityItems: [meal.image as Any, meal.category, meal.ingredients, meal.recipe, meal.nutrients], applicationActivities: nil)
            
            present(activityVC, animated: true)
        }
    }

}
