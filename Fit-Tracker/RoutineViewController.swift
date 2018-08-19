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

    @IBOutlet weak var routineNameField: UITextField!

    
    @IBAction func addExerciseButton(_ sender: UIButton) {
        //performSegue(withIdentifier: "GoToExercise", sender: self)
     
    }
    
    
    @IBOutlet weak var exerciseTable: UITableView!
    
    var routineName = ""
    //List of all exercises
    var exercises = [Exercise]()
    //List of selected exercises
    private var selectedExercises = [Exercise] ()
    
   //If true then it means that we are editing a routine
    var editMode = false
    
    //Refreshes the selected exercises and the routineName
    private func refreshSelectedExercises() {
        
        selectedExercises.removeAll()
        for e in exercises {
            if(e.isSelected) {
                selectedExercises.append(e)
            
            }
        }
    }
    
    private  func setupBarButtons() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem = saveButton
        self.navigationItem.hidesBackButton = true
        
    }
        @objc private func save() {
            if(self.routineNameField.text == "" || self.routineNameField.text == nil){
                let alert = UIAlertController(title:"Error", message: "Enter a name for your routine!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                
                
                self.present(alert, animated: true, completion: nil)

            }
            else
            {
                
        
            //TODO:
                //Load routines and append new routine on it --> Save routines
                refreshSelectedExercises()
                var loadedRoutines = [Routine]()
                //Load
                let userDefaults = UserDefaults.standard
                let decoded = userDefaults.object(forKey: "routines") as! Data?
                loadedRoutines = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [Routine]
            
            
                    for r in loadedRoutines {
                        if(r.name == routineNameField.text) {
                            let alert = UIAlertController(title:"Error", message: "There already exits a routine with this name!", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default,handler: nil))
                            
                            
                            self.present(alert, animated: true, completion: nil)
                            break
                        }
                    }
                    let routine = Routine(name:routineNameField.text!, exercises:selectedExercises)
                    
                    //Append
                    loadedRoutines.append(routine)
                    //Save
                    let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: loadedRoutines)
                    userDefaults.set(encodedData, forKey: "routines")
                    userDefaults.synchronize()
                    
                    
                    
                    // _ = navigationController?.popViewController(animated: true)
                    
                    //     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    // you need to cast this next line to the type of VC.
                    let vc = storyboard?.instantiateViewController(withIdentifier: "WorkoutViewController") as! WorkoutViewController // or whatever it is
                    // vc is the controller. Just put the properties in it.
                    // vc.routines.append(routine)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
    
            }
    }
                        
             
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="GoToExercise"){
            print("Going")
            let destVC = segue.destination as! ExerciseViewController
            destVC.exercises = exercises
           
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        exerciseTable.dataSource = self
        exerciseTable.delegate = self
        exerciseTable.tableFooterView = UIView()
        if exercises.count == 0 {
        loadExercises()
        }
        refreshSelectedExercises()
        setupBarButtons()
        
        routineNameField.text = routineName
        
        if(editMode){
            self.title = "Edit Mode"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCell2 = self.exerciseTable.dequeueReusableCell(withIdentifier: "customCell2") as! CustomCell2
        
        cell.nameLabel?.text = self.selectedExercises[indexPath.row].name
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return selectedExercises.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    private  func loadExercises() {
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
    }
}
