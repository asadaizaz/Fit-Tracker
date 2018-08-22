//
//  LiveWorkoutViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-19.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

//TODO: numberofRows should return a variable that addSet should increment. Figure out way to update for each section as this will add rows for every section



class LiveWorkoutCell: UITableViewCell {
    
  
    @IBOutlet weak var setNumberText: UITextField!
    
    @IBOutlet weak var repNumberText: UITextField!
    @IBOutlet weak var lbsNumberText: UITextField!
   
    
}
class LiveWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var routineNameText: UILabel!
    
    @IBOutlet weak var exerciseTableView: UITableView!
    //MARK: Actions
    
    //VARIABLES
    var routine: Routine?
    var setNumber = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        routineNameText.text = routine?.name
        exerciseTableView.rowHeight = UITableViewAutomaticDimension
        exerciseTableView.estimatedRowHeight = 300
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LiveWorkoutCell = self.exerciseTableView.dequeueReusableCell(withIdentifier: "LiveWorkoutCell") as! LiveWorkoutCell
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (routine?.exercises.count)!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return routine?.exercises[section].name
    }
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 343, height: 30))
        // here is what you should add:
        doneButton.center = footerView.center
        
        doneButton.setTitle("Add Set", for: .normal)
        doneButton.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        doneButton.backgroundColor = UIColor(displayP3Red: 0.9176470588, green: 0.9411764706, blue: 1, alpha: 1)
        doneButton.tag = section
        
        doneButton.addTarget(self, action: #selector(addSet(sender:)), for: .touchUpInside)
        
        
        footerView.addSubview(doneButton)
        return footerView
    }
    
    @objc func addSet(sender: UIButton!) {
        print("Add set!")
        exerciseTableView.beginUpdates()
        exerciseTableView.insertRows(at: [IndexPath(row: 2, section: sender.tag)], with: .automatic)
        exerciseTableView.endUpdates()
    }
    

}
