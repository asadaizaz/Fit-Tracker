//
//  RoutineViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit

class CustomCell2 : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
}
class RoutineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var routineNameField: UITextField!
    @IBOutlet weak var exerciseTable: UITableView!
    
    //MARK: Actions
    @IBAction func addExerciseButton(_ sender: UIButton) {
        //performSegue(withIdentifier: "GoToExercise", sender: self)
        
    }
    
    
    //MARK: VARIABLES
    
    //Stores the routine name that we send from WorkOutView, need to use this as textField reloads when view reloads
    var routineName = ""
    //List of only selected exercises sent from WorkOutView
    var exercises = [Exercise]()
    //All default exercises, not selected
    private var allExcercises = [Exercise]()
    //If true then it means that we are editing a routine
    var editMode = false
    
    //MARK: FUNCTIONS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        exerciseTable.dataSource = self
        exerciseTable.delegate = self
        exerciseTable.tableFooterView = UIView()
        
        //If no exercises, then populate with default
        
        setupBarButtons()
        
        routineNameField.text = routineName
        
        if(editMode){
            self.title = "Edit Mode"
        }
    }
    private func saveTemporaryRoutineName(){
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: routineNameField.text!)
        userDefaults.set(encodedData, forKey: "routineName")
        userDefaults.synchronize()
    }
    private func loadTemporaryRoutineName(){
        let userDefaults = UserDefaults.standard
        var loadedName = ""
    if (userDefaults.object(forKey: "routineName") != nil) {
        let decoded = userDefaults.object(forKey: "routineName") as! Data?
        loadedName = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! String
        routineNameField.text = loadedName
        }
    }
    //Returns a list of all exercises with the appropriate ones selected
    private func returnUpdatedExercises() -> [Exercise] {
        var selectedExercises = [Exercise]()
        selectedExercises =  loadDefaultExercises(exercises: &selectedExercises)
        for ea in selectedExercises {
            for e in exercises {
                if (e.name == ea.name){
                    ea.isSelected = true
                }
            }
        }
        return selectedExercises
    }

    private func showAlert(title:String, message:String){
        let alert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    private  func setupBarButtons() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.hidesBackButton = true
        
    }
    private func getLoadedRoutines() -> [Routine] {
        var loadedRoutines = [Routine]()
        
        //Load
        let userDefaults = UserDefaults.standard
        let decoded = userDefaults.object(forKey: "routines") as! Data?
        loadedRoutines = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Routine]
        return loadedRoutines
    }
    private func saveRoutines(routines: [Routine]) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: routines)
        userDefaults.set(encodedData, forKey: "routines")
        userDefaults.synchronize()
    }
    private func isRoutineDuplicate(routineName: String) -> Bool{
        var loadedRoutines = [Routine]()
        loadedRoutines = getLoadedRoutines()
        for r in loadedRoutines {
            if (r.name == routineName) {
                return true
            }
        }
        return false
    }
    private func replaceRoutine(routineList: inout[Routine]) -> [Routine] {
        for (index, r) in routineList.enumerated() {
            if (r.name == routineNameField.text) {
                routineList.remove(at: index)
                
                let routine = Routine(name:routineNameField.text!, exercises:exercises)
                //Append
                routineList.append(routine)
                return routineList
            }
        }
        return routineList
    }
    @objc private func save() {
        
        if(self.routineNameField.text == "" || self.routineNameField.text == nil){
            
            showAlert(title: "Error", message: "Enter a name for your routine!")
        }
        else
        {
            var loadedRoutines = [Routine]()
            
            loadedRoutines = getLoadedRoutines()
            
            if(!editMode){
                
                if(isRoutineDuplicate(routineName: routineNameField.text!)){
                    showAlert(title: "Error", message: "There already exists a routine with this name")
                }else{
                //If routine is not a duplicate and not in editmode
                
                let routine = Routine(name:routineNameField.text!, exercises:exercises)
                
                //Append
                loadedRoutines.append(routine)
                //Save
                saveRoutines(routines: loadedRoutines)
                
                
                }
            }
            //If in editmode
            else{
                if(!isRoutineDuplicate(routineName: routineNameField.text!)){
                   // fatalError("edit mode failed!:(")
                }
                //replace routine in loaded routine
                loadedRoutines = replaceRoutine(routineList: &loadedRoutines)
                saveRoutines(routines: loadedRoutines)
            }
    
                let vc = storyboard?.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController
            
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="GoToExercise"){
            print("Going")
            let destVC = segue.destination as! ExerciseViewController
            destVC.exercises = returnUpdatedExercises()
            destVC.editMode = editMode
            destVC.routineName = routineNameField.text!
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCell2 = self.exerciseTable.dequeueReusableCell(withIdentifier: "customCell2") as! CustomCell2
        
        cell.nameLabel?.text = self.exercises[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercises.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    private  func loadDefaultExercises(exercises:inout[Exercise]) -> [Exercise] {
        let e1 = Exercise(name: "Deadlift")
        let e2 = Exercise(name: "Bench Press")
        let e3 = Exercise(name: "Overhead press")
        let e4 = Exercise(name: "Rope Pushdown")
        let e5 = Exercise(name: "Bicep Curl")
        let e6 = Exercise(name: "Lat Pulldown")
        let e7 = Exercise(name: "Face Pull")
        let e8 = Exercise(name: "Cable Row")
        let e9 = Exercise(name: "Hammer Curl")
        let e10 = Exercise(name: "Plank")
        let e11 = Exercise(name: "Sit-Up")
        let e12 = Exercise(name: "Crunches")
        let e13 = Exercise(name: "Lateral Raise")
        let e14 = Exercise(name: "Incline Bench Press")
        let e15 = Exercise(name: "Shrug")
        let e16 = Exercise(name: "Squat")
        
        exercises += [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10, e11, e12, e13, e14, e15, e16]
        return exercises
    }

}
