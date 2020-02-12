//
//  ViewController.swift
//  TableView
//
//  Created by Артем  on 2/10/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func addNumbers () -> [Int]{
        var numbersOne = [Int]()
        for i in 1...100 {
            numbersOne.append(i)
        }
        return numbersOne
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return addNumbers().count
    }

     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        sell.textLabel?.text = String(addNumbers()[indexPath.row])
        return sell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

