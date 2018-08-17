//
//  ExerciseViewController.swift
//  Fit-Tracker
//
//  Created by Asad Aizaz on 2018-08-17.
//  Copyright © 2018 Asad Aizaz. All rights reserved.
//

import UIKit
class CustomCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
}
class ExerciseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var exercises = [Exercise]()


    private  func setupBarButtons() {
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.save))
        self.navigationItem.rightBarButtonItem = saveButton
        
        let discardButton = UIBarButtonItem(title: "Discard", style: .plain, target: self, action: #selector(self.discard))
        self.navigationItem.leftBarButtonItem = discardButton
        
    }
    
    
   
    @objc private func save() {
        print("saved!")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // you need to cast this next line to the type of VC.
        let vc = storyboard.instantiateViewController(withIdentifier: "RoutineViewController") as! RoutineViewController // or whatever it is
        // vc is the controller. Just put the properties in it.
        vc.exercises = exercises
        
        self.navigationController?.pushViewController(vc, animated: true)
      // _ = navigationController?.popViewController(animated: true)
    }
    
    @objc private func discard() {
        print ("discarded")
        
        //TODO: POPUP dialog
        
       _ = navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setupBarButtons()
        navigationController?.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:CustomCell = self.tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomCell
        
        cell.nameLabel?.text = self.exercises[indexPath.row].name
        if (exercises[indexPath.row].isSelected){
            cell.accessoryType = .checkmark

        }
        else{
            cell.accessoryType = .none
        }
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
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
                self.exercises[indexPath.row].isSelected = false
            }
            else{
                cell.accessoryType = .checkmark
                self.exercises[indexPath.row].isSelected = true
                print(self.exercises[indexPath.row].name + " selected!")
            }
        }
        
    }
}
