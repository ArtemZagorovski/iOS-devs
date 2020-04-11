//
//  TypePopOverVC.swift
//  YOUCAN
//
//  Created by Артем  on 4/1/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit

protocol PickTypeDelegate {
    func pickType(type: String)
}

class TypePopOverVC: UITableViewController {
    
    var delegation: PickTypeDelegate?
    var type: String?

    let typesOfGoals = ["Sport", "Education", "Music", "Hobbies", "Save Money"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesOfGoals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell", for: indexPath)
        
        cell.imageView?.image = UIImage(named: typesOfGoals[indexPath.row])
        cell.textLabel?.text = typesOfGoals[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        type = typesOfGoals[indexPath.row]
        delegation?.pickType(type: type!)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: tableView.contentSize.width, height: tableView.contentSize.height)
    }

}
