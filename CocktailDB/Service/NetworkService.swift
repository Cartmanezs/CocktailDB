//
//  NetworkService.swift
//  CocktailDB
//
//  Created by Ingvar on 19.10.2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {


    static let shared = NetworkService()
    private init() {}
    
    func getCategories(completion: @escaping (_ categories: DrinkCategories?, _ error: String?) -> Void ) {
        AF.request("https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list", method: .get).responseString { (response) in
        
        switch response.result {
            case .success(let result):

                if let jsonValue = response.value,
                    let jsonData = jsonValue.data(using: .utf8) {
                    let categories = try? JSONDecoder().decode(DrinkCategories.self, from: jsonData)
                    completion(categories, nil)
                }
               
           case .failure(let encodingError ):
            if let error = encodingError as? URLError {
                completion(nil, error.localizedDescription)
            } else {
               completion(nil, "error")
            }
        }
    }
}
    
    func getDrinksByCategory(category: String, completion: @escaping (_ drinks: DrinkInfo?, _ error: String?) -> Void ) {
        AF.request("https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(category)",
            method: .get).responseString { (response) in
         
         switch response.result {
             case .success(let result):

                 if let jsonValue = response.value,
                     let jsonData = jsonValue.data(using: .utf8) {
                     let drinks = try? JSONDecoder().decode(DrinkInfo.self, from: jsonData)
                     completion(drinks, nil)
                 }
                 
                 
             case .failure(let encodingError ):
             if let error = encodingError as? URLError {
                 completion(nil, error.localizedDescription)
             } else {
                completion(nil, "error")
             }
             }
         }
     }
}

