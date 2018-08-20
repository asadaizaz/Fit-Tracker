//
//  ChooseRoutineViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-19.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit
class CustomCellChooseRoutine: UITableViewCell {
    
    @IBOutlet weak var nameField: UILabel!
}
class ChooseRoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var routineTableView: UITableView!
    
    var loadedRoutines = [Routine]()
    
    
    private func loadRoutines(){
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "routines") != nil)
        {
            let decoded = userDefaults.object(forKey: "routines") as! Data?
            loadedRoutines = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Routine]
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedRoutines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CustomCellChooseRoutine = self.routineTableView.dequeueReusableCell(withIdentifier: "customCellChooseRoutine") as! CustomCellChooseRoutine
        cell.nameField.text = loadedRoutines[indexPath.row].name
       
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRoutines()
        routineTableView.dataSource = self
        routineTableView.delegate = self
        // Do any additional setup after loading the view.
    }


    

    

}
