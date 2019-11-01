//
//  ViewController.swift
//  Lab4
//
//  Created by Cody Tavenner on 2/18/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cityTable: UITableView!
    
    var myCityList:cityModel =  cityModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCityList.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "city1", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        cell.cityName.text = myCityList.cities[indexPath.row].cityName;
        cell.cityimage.image = UIImage(named: myCityList.cities[indexPath.row].cityImageName!)
        
        
        return cell
        
    }
    
    // delete table entry
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        // delete the data from the fruit table,  Do this first, then use method 1 or method 2
        myCityList.cities.remove(at: indexPath.row)
        
        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()
        
    }

    @IBAction func AddCity(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
            // Do this first, then use method 1 or method 2
            if let name = alert.textFields?.first?.text {
                print("Your name: \(name)")
                let f6 = city(fn: name, fin: "tempe.jpeg")
                self.myCityList.cities.append(f6)
                
                //Method 1
                
                let indexPath = IndexPath (row: self.myCityList.cities.count - 1, section: 0)
                self.cityTable.beginUpdates()
                self.cityTable.insertRows(at: [indexPath], with: .automatic)
                self.cityTable.endUpdates()
                
            }
        }))
        
        self.present(alert, animated: true)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let city = myCityList.cities[selectedIndex.row]
        
        
        
        if(segue.identifier == "cityView"){
            if let viewController: CityViewController = segue.destination as? CityViewController {
                viewController.selectedCity = city.cityName;
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

