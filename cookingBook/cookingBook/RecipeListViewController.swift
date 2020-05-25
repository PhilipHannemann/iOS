//
//  ViewController.swift
//  cookingBook
//
//  Created by Philip Hannemann on 02.05.20.
//  Copyright © 2020 Philip Hannemann. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    private let reuseIdentifierNormalCell = "RecipeCell"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var recipeListView: UICollectionView!{
        didSet {
            recipeListView.dataSource = self
            recipeListView.delegate = self
        }
    }
    
    var recipeList = RecipeList()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipeList.recipes.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierNormalCell, for: indexPath)
        
        if let recipeCellView = cell as? RecipeCellView, let recepiCell = recipeList.getRecipe(for: indexPath.item){
            recipeCellView.recipeName.text = recepiCell.name
            recipeCellView.recipeImage.image = UIImage(data: recepiCell.image)
            recipeCellView.layer.cornerRadius = 5
            recipeCellView.recipeImage.layer.cornerRadius = 5
            
            let frameWidth = recipeListView.bounds.width.double
            let containerWidth = frameWidth / LayoutConstraints.itemsPerRow
            let width =  containerWidth - LayoutConstraints.spacingBetweenItems - 2 * LayoutConstraints.standartSpacing
            recipeCellView.imageWidthConstraint.constant = CGFloat(width)
            
        }
        
    
       return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let layout = UIEdgeInsets(top: CGFloat(LayoutConstraints.spacingBetweenItems / 2),
                                  left: CGFloat(LayoutConstraints.spacingBetweenItems / 2),
                                  bottom: CGFloat(LayoutConstraints.spacingBetweenItems / 2), right:  CGFloat(LayoutConstraints.spacingBetweenItems / 2))

        return layout
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier, identifier == "showDetail"{
            if let cell = sender as? RecipeCellView {
                let cellIndex = recipeListView.indexPath(for: cell)?.item ?? 0
                let recipe = recipeList.getRecipe(for: cellIndex)
                
                if let detailView = segue.destination as? RecipeDetailViewController {
                    detailView.heading = recipe?.name ?? ""
                }
            }
        }
    }
    
    
    
}


extension RecipeListViewController {
    struct LayoutConstraints{
        static let itemsPerRow = 3.0
        static let spacingBetweenItems = 10.0
        static let standartSpacing = 8.0
    }
}

extension CGFloat {
    var double:Double {
        return Double(self)
    }
}
