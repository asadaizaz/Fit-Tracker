//
//  WorkoutViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-15.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit
class CustomCell3: UITableViewCell{
    
    @IBOutlet weak var exerciseName: UILabel!
    @IBOutlet weak var routineTitle: UILabel!
}
class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: Properties

    @IBOutlet weak var tableView: UITableView!
    var routines = [Routine]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCell3 = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell3") as! CustomCell3
        cell.routineTitle?.text = routines[indexPath.row].name
        cell.exerciseName?.text = "TEST"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return routines.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
