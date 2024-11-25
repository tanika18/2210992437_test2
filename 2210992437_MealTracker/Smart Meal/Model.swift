//
//  Model.swift
//  Smart Meal
//
//  Created by Uddeshya Singh on 24/11/24.
//

import Foundation
import UIKit


struct Nutrients: Codable {
    var fats: Double
    var carbs: Double
    var proteins: Double
    var calories: Double
}


struct Meal: Codable {
    var mealName: String
    var category: String
    var recipe: String
    var ingredients: String
    var nutrients: Nutrients
    var imageData: Data
    var mealType: MealType
    
    var image: UIImage? {
        return UIImage(data: imageData)
    }
}

enum MealType: String, Codable {
    case breakfast, lunch, dinner, snacks
}

func getMealsFilePath() -> URL {
    let fileManager = FileManager.default
    let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentDirectory.appendingPathComponent("mealsData.json")
}

func saveMeals(meals: [Meal]) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(meals) {
        let filePath = getMealsFilePath()
        do {
            try encoded.write(to: filePath)
        } catch {
            print("Failed to write meals data to file: \(error)")
        }
    }
}

func loadMeals() -> [Meal]? {
    let filePath = getMealsFilePath()
    let fileManager = FileManager.default
    if fileManager.fileExists(atPath: filePath.path) {
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            if let decodedMeals = try? decoder.decode([Meal].self, from: data) {
                return decodedMeals
            }
        } catch {
            print("Failed to load meals data from file: \(error)")
        }
    }
    return nil
}


var myArray: [Meal] = [
    Meal(mealName: "Pizza",
         category: "veg",
         recipe: "First Step, Second Step, Third Step",
         ingredients: "Veggies, Maida, Cheese, Oil",
         nutrients: Nutrients(fats: 123, carbs: 200, proteins: 84, calories: 456),
         imageData: UIImage(named: "pizza")?.pngData() ?? Data(),
         mealType: .lunch),
    
    Meal(mealName: "Burger",
         category: "veg",
         recipe: "First Step, Second Step, Third Step",
         ingredients: "Veggies, Maida, Cheese, Oil",
         nutrients: Nutrients(fats: 45, carbs: 12, proteins: 321, calories: 64),
         imageData: UIImage(named: "burger")?.pngData() ?? Data(),
         mealType: .dinner),
    
    Meal(mealName: "Chicken",
         category: "non veg",
         recipe: "First Step, Second Step, Third Step",
         ingredients: "Veggies, Maida, Cheese, Oil",
         nutrients: Nutrients(fats: 400, carbs: 34, proteins: 40, calories: 800),
         imageData: UIImage(named: "chicken")?.pngData() ?? Data(),
         mealType: .dinner),
    
    Meal(mealName: "Sandwich",
         category: "veg",
         recipe: "First Step, Second Step, Third Step",
         ingredients: "Veggies, Maida, Cheese, Oil",
         nutrients: Nutrients(fats: 20, carbs: 40, proteins: 60, calories: 500),
         imageData: UIImage(named: "sandwich")?.pngData() ?? Data(),
         mealType: .breakfast),
]
