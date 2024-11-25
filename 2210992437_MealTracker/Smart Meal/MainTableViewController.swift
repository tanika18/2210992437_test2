//
//  MainTableViewController.swift
//  Smart Meal
//
//  Created by Uddeshya Singh on 24/11/24.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var meals               : [Meal] = []
    var mealsGroupedByType  : [MealType: [Meal]] = [:]
    var mealTypes           : [MealType] = []
    
    @IBOutlet var screen: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meals.append(contentsOf: loadMeals() ?? myArray)
        screen.dataSource = self
        screen.register(CustomTableViewCell.nib(), forCellReuseIdentifier: CustomTableViewCell.identifier)
        groupMealsByType()
    }
    

    func groupMealsByType() {
        mealsGroupedByType = Dictionary(grouping: meals, by: { $0.mealType })
        mealTypes = [.breakfast, .lunch, .dinner, .snacks]
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return mealTypes.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mealType = mealTypes[section]
        return mealsGroupedByType[mealType]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = screen.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.accessoryType = .disclosureIndicator
        
        let mealType = mealTypes[indexPath.section]
        let meal = mealsGroupedByType[mealType]?[indexPath.row]

        if let meal = meal {
            cell.calories.text = "\(meal.nutrients.calories) kCal"
            cell.foodName.text = meal.mealName
            cell.imgView.image = meal.image
            cell.imgView.layer.cornerRadius = 12
            cell.category.text = "\(meal.category)"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(mealTypes[section])"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealType = mealTypes[indexPath.section]
        let selectedMeal = mealsGroupedByType[mealType]?[indexPath.row]
            
        if let meal = selectedMeal {
            performSegue(withIdentifier: "passDetails", sender: meal)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let mealType = mealTypes[indexPath.section]
            
            if var mealsForType = mealsGroupedByType[mealType] {
                let mealToDelete = mealsForType[indexPath.row]
                
                mealsForType.remove(at: indexPath.row)
                mealsGroupedByType[mealType] = mealsForType
                
                if let index = meals.firstIndex(where: { $0.mealName == mealToDelete.mealName }) {
                    meals.remove(at: index)
                }
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "passDetails" {
            if let destinationVC = segue.destination as? detailTableViewController,
               let selectedMeal = sender as? Meal {
                destinationVC.selectedMeal = selectedMeal
            }
        }
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        if let sourceVC = segue.source as? AddTableViewController,
           let newMeal = sourceVC.newMeal {
            meals.append(newMeal)
            groupMealsByType()
            saveMeals(meals: meals)
            tableView.reloadData()
        }
    }
    

}
