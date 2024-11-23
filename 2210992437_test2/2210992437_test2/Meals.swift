//
//  Meals.swift
//  2210992437_test2
//
//  Created by student-2 on 23/11/24.
//

import Foundation
import UIKit

struct Meal {
    var breakfast : mealInput
    var lunch : mealInput
    var dinner : mealInput
    var snacks : mealInput
}

struct mealInput {
    var recipeName : String
    var Ingredients : [String]
    var preparationTime : Int
    var category : String
    var calorieCount : Int
    var Image : UIImage?
}

var Data : [Meal] = [
    Meal(breakfast: mealInput(recipeName: "Bread Butter", Ingredients: ["Bread", "Butter"], preparationTime: 5, category: "vegetarian", calorieCount: 30),
         lunch: mealInput(recipeName: "Mix Veg", Ingredients: ["Beans","Carrot","Peas"], preparationTime: 15, category: "Vegetarian", calorieCount: 40),
         dinner: mealInput(recipeName: "Rice Roti", Ingredients: ["Rice", "Wheat"], preparationTime: 30, category: "vegetarian", calorieCount: 80),
         snacks: mealInput(recipeName: "Carrot Juice", Ingredients: ["Carrot"], preparationTime: 10, category: "Gluten- Free", calorieCount: 100))
   
]
