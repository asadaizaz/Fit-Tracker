//
//  WorkoutViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-15.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit
class CustomCell3: UITableViewCell{
    

    
    
    @IBOutlet weak var routineTitle: UILabel!
  
}




class WorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    //MARK: ACTIONS
    @IBAction func createRoutineButton(_ sender: UIButton) {
        saveRoutines()
    }
    
    @IBAction func startWorkoutRoutine(_ sender: Any) {
        resetDefaults()
        tableView.reloadData()
    }
    
    //MARK: VARIABLES
    var routines = [Routine]()

    //MARK: Private functions
    private func saveRoutines() {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: routines)
        userDefaults.set(encodedData, forKey: "routines")
        userDefaults.synchronize()
        
    }
    
    private func loadRoutines() {
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "routines") != nil)
        {
            let decoded = userDefaults.object(forKey: "routines") as! Data?
            routines = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Routine]
            
        }
        
    }
   private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }

    
    //MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
       //resetDefaults()
        loadRoutines()
        self.navigationController?.viewControllers = [self]

        
    }
    //Use this function to send any data to RoutineView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toRoutineViewController") {
            print("Moving to routineView")
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCell3 = self.tableView.dequeueReusableCell(withIdentifier: "CustomCell3") as! CustomCell3
        cell.routineTitle?.text = routines[indexPath.row].name
       
        
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
        
        //Opens up the clicked on routine in RoutineView
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RoutineViewController") as! RoutineViewController //
        let routine = routines[indexPath.row]
        vc.exercises = routine.exercises
        vc.routineName = routine.name
        vc.editMode  = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            removeRoutine(routine: routines[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
           

            tableView.reloadData()
            
        }
    }
    
    func  removeRoutine(routine: Routine) {
       loadRoutines()
        for (index, r) in routines.enumerated(){
            if (r.name == routine.name){
                routines.remove(at: index)
            }
        }
        saveRoutines()
    }

}
