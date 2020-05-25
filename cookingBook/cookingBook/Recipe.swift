//
//  Recipe.swift
//  cookingBook
//
//  Created by Philip Hannemann on 02.05.20.
//  Copyright © 2020 Philip Hannemann. All rights reserved.
//

import Foundation


struct Recipe {
    
    var image = Data()
    var name = ""
    var ingredients:[]
    
    
    init(image:Data, name:String) {
        self.image = image
        self.name = name
    }
    
}
