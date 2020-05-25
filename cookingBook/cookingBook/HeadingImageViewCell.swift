//
//  HeadingImageViewCell.swift
//  cookingBook
//
//  Created by Philip Hannemann on 25.05.20.
//  Copyright © 2020 Philip Hannemann. All rights reserved.
//

import UIKit

class HeadingImageViewCell: UITableViewCell {

    @IBOutlet weak var topImage: UIImageView!
    
    var aspectCanstraint:NSLayoutConstraint?
    
    func set(image:UIImage){
        let ratio = image.size.height / image.size.width
        
        aspectCanstraint?.isActive = false
        
        aspectCanstraint = topImage.heightAnchor.constraint(equalTo: topImage.widthAnchor, multiplier: ratio)
        
        aspectCanstraint?.isActive = true
        
        topImage.image = image
    }
    
    
}
