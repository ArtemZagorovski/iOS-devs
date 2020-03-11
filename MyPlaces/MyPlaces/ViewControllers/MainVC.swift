//
//  MainVC.swift
//  MyPlaces
//
//  Created by Артем  on 2/17/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var places: Results<Place>!
    private var filtredPlaces: Results<Place>!
    private var ascendingSorting = true
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    private let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var reverseSortingButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        places = realm.objects(Place.self)
        
        //Setup search controller
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltring {
            return filtredPlaces.count
        }
        
        
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableVC
        
        let place = isFiltring ? filtredPlaces[indexPath.row] : places[indexPath.row]

        cell.nameLabel.text = place.name
        cell.locationLabel.text = place.location
        cell.typeLabel.text = place.type
        cell.imageOfPlace.image = UIImage(data: place.imageData!)
        cell.cosmosView.rating = place.rating


        return cell
    }
    
    
    //MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let place = places![indexPath.row]
            StorageManager.deliteObject(place)
        }
        //tableView.reloadData()
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    //MARK: - Navigation

     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let place = isFiltring ? filtredPlaces[indexPath.row] : places[indexPath.row]
            
            let newPlaceVC = segue.destination as! NewPlaceVC
            newPlaceVC.currentPlace = place 
        }
    }
    

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){

        guard let newPlaceVC = segue.source as? NewPlaceVC else { return }

        newPlaceVC.savePlace()

        tableView.reloadData()
    }
    
    @IBAction func sortSelection(_ sender: UISegmentedControl) {
        
        sorting()
        
    }
    @IBAction func reversedSorting(_ sender: UIBarButtonItem) {
        ascendingSorting.toggle()
        
        if ascendingSorting {
            reverseSortingButton.image = #imageLiteral(resourceName: "AZ")
        } else {
            reverseSortingButton.image = #imageLiteral(resourceName: "ZA")
        }
        sorting()
    }
    
    private func sorting() {
        if segmentedControl.selectedSegmentIndex == 0 {
            places = places.sorted(byKeyPath: "date", ascending: ascendingSorting)
        } else {
            places = places.sorted(byKeyPath: "name", ascending: ascendingSorting)
        }
        
        tableView.reloadData()
    }
}


extension MainVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText (_ searchText: String) {
        filtredPlaces = places.filter("name CONTAINS[c] %@ OR location CONTAINS[c] %@", searchText, searchText)
        tableView.reloadData()
    }
}
