//
//  Item.swift
//  CocktailDB
//
//  Created by Ingvar on 20.10.2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import Foundation


class Item {
    let name: String
    var enabled: Bool
    init(name: String, enabled: Bool) {
        self.name = name
        self.enabled = enabled
    }
}
