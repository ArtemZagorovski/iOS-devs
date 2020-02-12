//
//  TrackList.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/12/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit


class Tasks: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as! TableCellTableViewCell
        
        cell.toDoTitle.text = "Поручение № \(indexPath.row)"
        
        cell.toDoSubtitle.text = "Описание поручения № \(indexPath.row)"
        cell.toDoSubtitle.numberOfLines = 0
        cell.toDoSubtitle.alpha = 0.7
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDitail" {
            if let indexPath = self.tableView.indexPathForSelectedRow{
                let detailsVc = segue.destination as! DetailVC
                detailsVc.numberOfTask = "\(indexPath.row)"
            }
        }
    }
}
