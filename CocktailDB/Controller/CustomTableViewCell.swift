//
//  CustomTableViewCell.swift
//  CocktailDB
//
//  Created by Ingvar on 19.10.2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageOfDrink: UIImageView! {
        didSet {
            imageOfDrink.layer.cornerRadius = imageOfDrink.frame.size.height / 2
            imageOfDrink.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
}
