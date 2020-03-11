//
//  TrackList.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift

class Tasks: UITableViewController {
    
    private var cars: Results<Car>!
    
    @IBOutlet weak var sortingButton: UIBarButtonItem!
    var ascendingSorting = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cars = realm.objects(Car.self)
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! TableCellTableViewCell
        if cars.count > 0 {
            cell.brandLabel.text = cars[indexPath.row].brand
            cell.modelLabel.text = cars[indexPath.row].model
            cell.costLabel.text = String(cars[indexPath.row].cost)
            cell.carImage.image = UIImage(data: cars[indexPath.row].imageData!)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddCar" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let addCar = segue.destination as! AddCar
                addCar.currentCar = cars[indexPath.row]
            }
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){

        guard let addCar = segue.source as? AddCar else { return }

        addCar.saveCar()

        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = cars![indexPath.row]
            StorageManager.deliteObject(car)
        }
        
        //tableView.reloadData()
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            sortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            sortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    
    private func sorting() {
        cars = cars.sorted(byKeyPath: "cost", ascending: ascendingSorting)
        tableView.reloadData()
    }
}
