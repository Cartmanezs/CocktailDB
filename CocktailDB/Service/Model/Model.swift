//
//  Model.swift
//  CocktailDB
//
//  Created by Ingvar on 19.10.2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import Foundation

struct DrinkCategories: Decodable {
    let drinks: [DrinkCategory]?
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
    
    struct DrinkCategory: Decodable {
        let strCategory: String?
        
        enum CodingKeys: String, CodingKey {
            case strCategory
        }
    }
}

struct DrinkInfo: Decodable {
    let drinks: [DrinkCategory]?
    
    enum CodingKeys: String, CodingKey {
        case drinks
    }
    
    struct DrinkCategory: Decodable {
        let strDrink: String?
        let strDrinkThumb: String?
        let idDrink: String?
        
        enum CodingKeys: String, CodingKey {
            case strDrink
            case strDrinkThumb
            case idDrink
        }
    }
}


   
