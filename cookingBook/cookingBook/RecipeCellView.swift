//
//  RecipeCell.swift
//  cookingBook
//
//  Created by Philip Hannemann on 02.05.20.
//  Copyright © 2020 Philip Hannemann. All rights reserved.
//

import UIKit

class RecipeCellView: UICollectionViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
 
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageAspectRatio: NSLayoutConstraint!

    
}
