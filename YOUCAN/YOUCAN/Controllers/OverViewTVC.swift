//
//  OverViewTVC.swift
//  YOUCAN
//
//  Created by Артем  on 4/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift

@IBDesignable
class OverViewTVC: UITableViewController {
    
    let apiManager = APIManager()
    let locationManager = LocationManager()
    var coordinates: String!
    var currentWeather: Weather!
    var tasks: Results<Task>!
    var goals: Results<Goal>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goals = realm.objects(Goal.self)
        tasks = realm.objects(Task.self).sorted(byKeyPath: "time", ascending: true)
//        coordinates = locationManager.getCurrentLocation()
//        print("COORDINATES", coordinates)
//        getCurrentLocation()
//        setupScreen()
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.register(TaskProgrammCell.self, forCellReuseIdentifier: "TaskCell")
        tableView.register(GoalProgrammCell.self, forCellReuseIdentifier: "GoalCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinates = locationManager.getCurrentLocation()
        print("COORDINATES", coordinates)
        getCurrentLocation()
        tableView.reloadData()
        //setupScreen()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "section"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 1
        default:
            print("error in overview numberofrows")
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 1:
            return 80
        case 2:
            return 150
        default:
            print("error in overview heightforrowat")
        }
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let task = tasks.randomElement()
        let goal = goals.randomElement()
        getCurrentLocation()
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
            cell.weather = currentWeather
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskProgrammCell
            cell.task = task
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as! GoalProgrammCell
            cell.goal = goal
            return cell
        default:
            print("error in cellforrowat")
        }
        return UITableViewCell()
    }

    private func getCurrentLocation() {
        
        print("COORDINATES", coordinates)
        apiManager.getWeatherData(coordinates: coordinates, completionHandler: {[unowned self] (result) in
            //self.toggleActivityIndicator(on: false)
            
            switch result {
            case .Success(let currentWeather):
                self.currentWeather = currentWeather
                DispatchQueue.main.async {
                    //self.updateWeatherInfo(currentWeather: currentWeather)
                }
               
            case .Failure(let error as NSError):
                let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              alertController.addAction(okAction)
              
              self.present(alertController, animated: true, completion: nil)
            default: break
            }
        })
    }
}
