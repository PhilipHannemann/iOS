//
//  RecipeList.swift
//  cookingBook
//
//  Created by Philip Hannemann on 02.05.20.
//  Copyright © 2020 Philip Hannemann. All rights reserved.
//

import Foundation

class RecipeList {
    
    private (set) var recipes = [Recipe]()
    
    init() {
        
        for i in 1...30{
            recipes.append(Recipe(image: Data(), name: "Gericht\(i)"))
        }
        
    }
    
    
    func getRecipe(for index:Int)->Recipe?{
        
        if recipes.count > index && index >= 0 {
            return recipes[index]
        }
        
        return nil
    }
    
}
