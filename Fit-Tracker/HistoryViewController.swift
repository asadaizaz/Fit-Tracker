//
//  HistoryViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-25.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit
class CustomCellHistory: UITableViewCell {
    
    @IBOutlet weak var dateText: UILabel!
    
    @IBOutlet weak var timeText: UILabel!
}
class HistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var historyTable: UITableView!
    var loadedRoutines = [SavedRoutine] ()
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTable.delegate = self
        historyTable.dataSource = self
        loadHistory()
        
        
    }
    
    func loadHistory() {
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "history") != nil)
        {
            let decoded = userDefaults.object(forKey: "history") as! Data?
            loadedRoutines = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [SavedRoutine]
            for lr in loadedRoutines {
                print(lr.routine.name)
            }
            print("Loaded history routines!")
            print("The number of saved routines is: ", loadedRoutines.count)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedRoutines.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell:CustomCellHistory = self.historyTable.dequeueReusableCell(withIdentifier: "CustomCellHistory") as! CustomCellHistory
        let formatter = DateFormatter()
        let date = loadedRoutines[indexPath.row].date as Date
        
        formatter.dateFormat = "MMM-dd"
        let dateText = formatter.string(from: date)
        formatter.dateFormat = "HH:mm"
        let timeText = formatter.string(from: date)
        cell.dateText.text = dateText
        cell.timeText.text = timeText
        return cell
    }

    
}
