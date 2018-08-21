//
//  LiveWorkoutViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-19.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class LiveWorkoutCell: UITableViewCell {
    
    
}
class LiveWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var routineNameText: UILabel!
    
    @IBOutlet weak var exerciseTableView: UITableView!
    //MARK: Actions
    
    //VARIABLES
    var routine: Routine?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        routineNameText.text = routine?.name
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (routine?.exercises.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LiveWorkoutCell = self.exerciseTableView.dequeueReusableCell(withIdentifier: "LiveWorkoutCell") as! LiveWorkoutCell
        return cell
    }

}
