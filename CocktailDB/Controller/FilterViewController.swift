//
//  FilterViewController.swift
//  CocktailDB
//
//  Created by Ingvar on 20.10.2019.
//  Copyright © 2019 Igor. All rights reserved.
//

import UIKit



class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var applyFilterButton: UIBarButtonItem!
    
    let section = ["Filter by alcoholic", "Filter by Category", "Filter by Glass"]
    
    let items: [[Item]] = [
       [Item(name: "Alcoholic", enabled: false),
        Item(name: "Non-Alcoholic", enabled: false)],
       [Item(name: "Ordinary Drink", enabled: false),
        Item(name: "Cocktail", enabled: false)],
       [ Item(name: "Cocktail glass", enabled: false),
         Item(name: "Cocktail flute", enabled: false)]
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
        applyFilterButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func applyFilterButtonTapped(_ sender: Any) {
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        let item = items[indexPath.section][indexPath.row]
        cell.textLabel?.text =  item.name
        cell.accessoryType = item.enabled ? .checkmark : .none
              
        return cell
        
        
        
     }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         if let cell = tableView.cellForRow(at: indexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let item = items[indexPath.section][indexPath.row]
             
             item.enabled = !item.enabled
             if item.enabled {
                cell.accessoryType = .checkmark
                applyFilterButton.isEnabled = true
             } else {
                cell.accessoryType = .none
                applyFilterButton.isEnabled = false
             }
          
         }
     }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
