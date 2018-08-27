//
//  RoutineHistoryViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-26.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class CustomCellRoutineHistory: UITableViewCell {
    
    @IBOutlet weak var setNumberLabel: UILabel!
    
    @IBOutlet weak var repNumberLabel: UILabel!
    @IBOutlet weak var lbsNumberLabel: UILabel!
}
class RoutineHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
  
    @IBOutlet weak var tableView: UITableView!
    
    var routine: Routine?
    var loadedRoutines = [SavedRoutine] ()


  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (routine!.exercises[section].sets.count)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCellRoutineHistory = self.tableView.dequeueReusableCell(withIdentifier: "CustomCellRoutineHistory") as! CustomCellRoutineHistory

        cell.setNumberLabel.text = String(indexPath.row+1)
        let l: Int = (routine?.exercises[indexPath.section].sets[indexPath.row].lbsNumber)!
        let r: Int = (routine?.exercises[indexPath.section].sets[indexPath.row].repNumber)!
        cell.lbsNumberLabel.text = String(l)
        cell.repNumberLabel.text = String(r)

        
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        print(routine!.exercises.count)
        return (routine!.exercises.count)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return routine?.exercises[section].name
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
  
    
    
  

    

}
