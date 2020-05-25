//
//  RecipeDetailViewController.swift
//  cookingBook
//
//  Created by Philip Hannemann on 04.05.20.
//  Copyright © 2020 Philip Hannemann. All rights reserved.
//

import UIKit

struct Cells {
    static let headImageCell = "headImageCell"
    static let recipesCell = "RecipesCell"
    static let stepCell = "StepCell"
    static let editCell = "EditCell"
    static let ingredientCell = "IngredientCell"
}

class RecipeDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = heading
   
    }
    
    
    public var heading = "RezeptXY" {
        didSet {
            navigationItem.title = heading
        }
    }
    
    
    
    
}
