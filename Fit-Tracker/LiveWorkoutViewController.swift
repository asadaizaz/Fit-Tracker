//
//  LiveWorkoutViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-19.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class LiveWorkoutCell: UITableViewCell {
    
  
  
    @IBOutlet weak var setNumberText: UITextField!
    
    @IBOutlet weak var repNumberText: UITextField!
    @IBOutlet weak var lbsNumberText: UITextField!
    
    
    @IBOutlet weak var checkMarkButton: UIButton!
    var exercise: Exercise!
    var indexNumber: Int!
    var selectedExercises = [Exercise] ()
    @IBAction func checkMarkButton(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
        print("selcted")
        if (sender.isSelected){
            if( repNumberText.text?.isEmpty)! {
                repNumberText.text = "0"
            }
            if(lbsNumberText.text?.isEmpty)! {
                lbsNumberText.text = "0"
            }
            let  tempSet = Set(repNumber: Int(repNumberText.text!)!, lbsNumber: Int(lbsNumberText.text!)!, saved:false)
            exercise.sets[indexNumber] = tempSet
            sender.isSelected = false
            print(exercise.name, String(indexNumber))
            
        }
        else if (!sender.isSelected){
            if( repNumberText.text?.isEmpty)! {
                repNumberText.text = "0"
            }
            if(lbsNumberText.text?.isEmpty)! {
                lbsNumberText.text = "0"
            }
            let  tempSet = Set(repNumber: Int(repNumberText.text!)!, lbsNumber: Int(lbsNumberText.text!)!, saved:true)
            exercise.sets[indexNumber] = tempSet
            sender.isSelected = true
        }
        
        
    }
    
   @objc func updateSets() {
        if( repNumberText.text?.isEmpty)! {
            repNumberText.text = "0"
        }
        if(lbsNumberText.text?.isEmpty)! {
            lbsNumberText.text = "0"
        }
        let prevSaved = exercise.sets[indexNumber].saved
        let  tempSet = Set(repNumber: Int(repNumberText.text!)!, lbsNumber: Int(lbsNumberText.text!)!, saved: prevSaved)
        exercise.sets[indexNumber] = tempSet
    }
    override func layoutSubviews() {
         super.layoutSubviews()
        lbsNumberText.addTarget(self, action: #selector(self.updateSets), for: UIControlEvents.editingDidEnd)
        repNumberText.addTarget(self, action: #selector(self.updateSets), for: UIControlEvents.editingDidEnd)

        
    }
    
}




class LiveWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK: Properties
    
    @IBOutlet weak var routineNameText: UILabel!
    
    @IBOutlet weak var exerciseTableView: UITableView!
    
    //VARIABLES
    var routine: Routine?
    var savedRoutines = [SavedRoutine] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSetNumbers()

        exerciseTableView.delegate = self
        exerciseTableView.dataSource = self
        routineNameText.text = routine?.name
        exerciseTableView.rowHeight = UITableViewAutomaticDimension
        exerciseTableView.estimatedRowHeight = 500
        exerciseTableView.keyboardDismissMode = .onDrag
        setupBarButtons()
        let userDefaults = UserDefaults.standard
        if (userDefaults.object(forKey: "history") != nil)
        {
            let decoded = userDefaults.object(forKey: "history") as! Data?
            savedRoutines = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [SavedRoutine]
            
        }
      
        
    }
    

    func initializeSetNumbers(){
        
        let set = Set(repNumber: 0,lbsNumber: 0)
        for e in ((routine?.exercises))! {
            e.sets.append(set)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (routine?.exercises[section].sets.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:LiveWorkoutCell = self.exerciseTableView.dequeueReusableCell(withIdentifier: "LiveWorkoutCell") as! LiveWorkoutCell
        
        let temp = indexPath.row+1
        cell.setNumberText.text = String(temp)
        
        cell.checkMarkButton.setImage(#imageLiteral(resourceName: "checkmark-Off"), for: UIControlState.normal)
        cell.checkMarkButton.setImage(#imageLiteral(resourceName: "checkmark-On"), for: UIControlState.selected)
        
        let tempExercise = routine?.exercises[indexPath.section]
        cell.exercise = tempExercise
        
       
        let tempSet =  tempExercise?.sets[indexPath.row]
        let r: Int = (tempSet?.repNumber)!
        let l: Int = (tempSet?.lbsNumber)!
        cell.indexNumber = indexPath.row
        cell.repNumberText.text = String(r)
        cell.lbsNumberText.text = String(l)
        
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
        print(sender.tag)

        exerciseTableView.beginUpdates()
  
        
        exerciseTableView.insertRows(at: [IndexPath(row: (routine?.exercises[sender.tag].sets.count)!, section: sender.tag)], with: .automatic)
        routine?.exercises[sender.tag].sets.append(Set(repNumber: 0, lbsNumber: 0))

        exerciseTableView.endUpdates()
    }
    private  func setupBarButtons() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
   
    @objc func save() {
        let tempRoutine = Routine(name: (self.routine?.name)!, exercises: (self.routine?.exercises)!)
        
        for e in tempRoutine.exercises {
            for (_, s) in e.sets.enumerated() {
                if (!s.saved) {
                    e.sets = e.sets.filter { $0 != s}

                
            }
        }
    }
        
        let tempSavedRoutine = SavedRoutine(routine: tempRoutine, date: NSDate())
        //Save in userdefaults
        savedRoutines.append(tempSavedRoutine)
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: savedRoutines)
        userDefaults.set(encodedData, forKey: "history")
        userDefaults.synchronize()
        
     //Return to main screen
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController //
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }

}

