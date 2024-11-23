//
//  DetailViewController.swift
//  2210992437_test2
//
//  Created by student-2 on 23/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    var meals : Meal?
    
   
    
    @IBOutlet var name: UITextField!
    
    @IBOutlet var ingedients: UITextField!
    
    @IBOutlet var time: UITextField!
    
    @IBOutlet var category: UITextField!
    
    @IBOutlet var calorie: UITextField!
    
    @IBOutlet var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meals = meals {
            name.text = "\(String(describing: meals.breakfast.recipeName))"
            ingedients.text = "\(String(describing: meals.breakfast.Ingredients))"
            time.text = "\(String(describing: meals.breakfast.preparationTime))"
            category.text = meals.breakfast.category
            calorie.text = "\(meals.breakfast.calorieCount)"
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
