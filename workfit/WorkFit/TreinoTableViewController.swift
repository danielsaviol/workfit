//
//  TreinoTableViewController.swift
//  WorkFit
//
//  Created by IFCE on 23/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TreinoTableViewController: UITableViewController {
    
    var refresher: UIRefreshControl!
    
    
    @IBOutlet var weekTableView: UITableView!
    
    var training : [String] = ["","","","","","",""]
    
    var weekDic  = [ ["seg", "Segunda-feira"], ["ter", "Terça-feira"], ["qua", "Quarta-feira"], ["qui", "Quinta-feira"], ["sex", "Sexta-feira"], ["sab", "Sábado"], ["dom", "Domingo"] ]
    
    
    var ref:FIRDatabaseReference?
    var databaseHandleWeek:FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1755665541, green: 0.1990170777, blue: 0.2529973984, alpha: 1)
        firebaseRead()
        
        refresher = UIRefreshControl()
        refresher.tintColor = #colorLiteral(red: 0.1450980392, green: 0.6078431373, blue: 0.9529411765, alpha: 1)
        refresher.addTarget(self, action: #selector(TreinoTableViewController.refresh), for: UIControlEvents.valueChanged)
        weekTableView.addSubview(refresher)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1755665541, green: 0.1990170777, blue: 0.2529973984, alpha: 1)
        tabBarController?.tabBar.isHidden = false
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return training.count+1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 100
        }
        else{
            return 90
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerLayoutCell", for: indexPath)
            return cell
        }
        else{
            let cell:treinoCustomCell = tableView.dequeueReusableCell(withIdentifier: "daysOfWeek", for: indexPath) as! treinoCustomCell
            cell.textLabel?.textColor = #colorLiteral(red: 0.9963582925, green: 1, blue: 0.9969385177, alpha: 1)
            cell.selectionStyle = .none
            cell.textLabel?.font = UIFont(name:"Helvetica Neue", size:20)
            
            cell.dayLabel.text = weekDic[indexPath.row-1][1]
            cell.trainingLabel.text = training[indexPath.row-1]
            cell.viewBack.layer.cornerRadius = 15
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        }
        else{
            let cell = tableView.cellForRow(at: indexPath)
            if training[indexPath.row-1] != "Descanso"{
                self.performSegue(withIdentifier: "transitionTrain", sender: cell)
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transitionTrain" {
            let destinationController = segue.destination as! VisualizaTreinoTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationController.toWeek = weekDic[indexPath.row-1][1]
                destinationController.toWeekAbr = weekDic[indexPath.row-1][0]
            }
            
        }
    }
    
    func refresh (){
        
        training.removeAll()
        training = ["","","","","","",""]
        refresher.endRefreshing()
        firebaseRead()
    }
    
    func firebaseRead(){
        training.removeAll()
        training = ["","","","","","",""]
        databaseHandleWeek = ref?.child("Train").observe(.childAdded, with: { (snapshot) in
            if snapshot.key == userTrainID {
                let post = snapshot.value as? Dictionary<String, Any>
                
                if let actualPost = post {
                    var readMuscle = ["","","","","","",""]
                    for key in actualPost.keys {
                        for index in 0...6{
                            if key.contains(self.weekDic[index][0]){
                                readMuscle[index].append((actualPost[key] as! Dictionary<String, Any>)["musculo"] as! String)
                            }
                        }
                    }
                    self.training = readMuscle
                    self.weekTableView.reloadData()
                }
            }
        })
        
    }
    
}
