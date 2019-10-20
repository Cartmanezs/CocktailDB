//
//  ViewController.swift
//  CocktailDB
//
//  Created by Ingvar on 19.10.2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var allDrinks = [DrinkInfo.DrinkCategory]()
    private var drinksArray = [DrinkInfo.DrinkCategory]()
    
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        activityView.startAnimating()
        getData()
        
        // Do any additional setup after loading the view.
    }
    
    private func getData() {
        
        NetworkService.shared.getCategories { (categories, error) in
            
            if let categories = categories {
                   
                guard let drinkCategories = categories.drinks else { return }
                var categoryCounter = 0
                    
                for drinkCategory in drinkCategories {
                         
                if let categoryName = drinkCategory.strCategory {
                     NetworkService.shared.getDrinksByCategory(category: categoryName) { (drinks, error) in
                            categoryCounter += 1
                            if let drinksInfo = drinks?.drinks {
                                var drinkCounter = 0
                                for drink in drinksInfo {
                                    self.allDrinks.append(drink)
                                    drinkCounter += 1
                                    if categoryCounter == drinkCategories.count &&
                                        drinkCounter == drinksInfo.count {
                                        self.drinksArray = Array(self.allDrinks[0...11])
                                            self.tableView.reloadData()
                                            self.activityView.stopAnimating()
                                            self.activityView.isHidden = true
                                            self.tableView.isHidden = false
                                            

                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
   func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let offsetY = scrollView.contentOffset.y
       let contentHeight = scrollView.contentSize.height
       
        if offsetY > contentHeight - scrollView.frame.height  {
           if !fetchingMore {
               beginBatchFetch()
           }
       }
   }
   
   func beginBatchFetch() {
       fetchingMore = true
       DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        
        var i = self.drinksArray.count
        var finalIndex = i + 12
        while i < finalIndex {
            if i < self.allDrinks.count {
                self.drinksArray.append(self.allDrinks[i])
            }
           i += 1
        }
        self.fetchingMore = false
        self.tableView.reloadData()
       })
   }
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return  drinksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let drink = drinksArray[indexPath.row]
        cell.nameLabel.text = drink.strDrink
        if let drinkURLString = drink.strDrinkThumb,
            let url = URL(string: drinkURLString),
            let data = try? Data(contentsOf: url)
            {
                cell.imageOfDrink.image = UIImage(data: data)
            }
        
        return cell 
    }
    

 

    
    
    //MARK: Table View Delegete
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


