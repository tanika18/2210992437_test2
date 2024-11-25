//
//  AddTableViewController.swift
//  Smart Meal
//
//  Created by Uddeshya Singh on 24/11/24.
//

import UIKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var proteinField: UITextField!
    @IBOutlet weak var fatField: UITextField!
    @IBOutlet weak var carbsField: UITextField!
    @IBOutlet weak var caloriesField: UITextField!
    @IBOutlet weak var ingredientField: UITextField!
    @IBOutlet weak var recipeField: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mealField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var mealTypeField: UITextField!
    
    var newMeal: Meal? {
        if let mealName = mealField.text, !mealName.isEmpty,
           let type = mealTypeField.text, !type.isEmpty,
           let category = categoryField.text, !category.isEmpty,
           let recipe = recipeField.text, !recipe.isEmpty,
           let ingredients = ingredientField.text, !ingredients.isEmpty,
           let proteinText = proteinField.text, let protein = Double(proteinText),
           let fatText = fatField.text, let fat = Double(fatText),
           let carbsText = carbsField.text, let carbs = Double(carbsText),
           let caloriesText = caloriesField.text, let calories = Double(caloriesText),
           let image = imgView.image?.pngData() {
            
            return Meal(
                mealName: mealName,
                category: category,
                recipe: recipe,
                ingredients: ingredients,
                nutrients: Nutrients(fats: fat, carbs: carbs, proteins: protein, calories: calories),
                imageData: image,
                mealType: type.lowercased() == "breakfast" ? .breakfast :
                          type.lowercased() == "lunch" ? .lunch :
                          type.lowercased() == "dinner" ? .dinner : .snacks
            )
        } else {
            print("Error: Missing or invalid fields.")
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func uploadImage(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Select Image", message: "Choose how you'd like to select your image", preferredStyle: .actionSheet)
            
            let photos = UIAlertAction(title: "Photo Library", style: .default) { _ in
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            }
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let picker = UIImagePickerController()
                    picker.delegate = self
                    picker.sourceType = .camera
                    self.present(picker, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Camera not available", message: "Your device does not have a camera.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        actionSheet.addAction(photos)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancelAction)
            
        present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
