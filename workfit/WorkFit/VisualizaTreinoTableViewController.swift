//
//  VisualizaTreinoTableViewController.swift
//  WorkFit
//
//  Created by IFCE on 02/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

class VisualizaTreinoTableViewController: UITableViewController {
    
    var refresher: UIRefreshControl!
    
    
    
    @IBOutlet var trainingTableView: UITableView!
    
    
    var toWeek = ""
    var toWeekAbr = ""
    
    var trainingName = [String]()
    var trainingInfo = [String]()
    var ref:FIRDatabaseReference?
    var databaseHandleTraining:FIRDatabaseHandle?
    var databaseHandleNameTraining:FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1755665541, green: 0.1990170777, blue: 0.2529973984, alpha: 1)
        
        self.title = toWeek
        
        ref = FIRDatabase.database().reference()
        firebaseRead()
        
        refresher = UIRefreshControl()
        refresher.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        refresher.addTarget(self, action: #selector(VisualizaTreinoTableViewController.refresh), for: UIControlEvents.valueChanged)
        trainingTableView.addSubview(refresher)
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trainingName.count-1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trainingCell", for: indexPath) as! TrainingCustomCell
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont(name:"Helvetica Neue", size:20)
        cell.viewBack.layer.cornerRadius = 15
        cell.lbExerc.text = trainingName[indexPath.row+1]
        cell.lbExerc.text = cell.lbExerc.text?.uppercased()
        databaseHandleTraining = ref?.child("Train").child(userTrainID).child(toWeekAbr).child(trainingName[indexPath.row+1]).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post {
                self.trainingInfo.append(actualPost)
                if self.trainingInfo.indices.contains(2){
                    cell.lbMusc.text = self.trainingInfo[0]
                    cell.lbObs.text = self.trainingInfo[1]
                    cell.lbReps.text = self.trainingInfo[2]
                    self.trainingInfo.removeAll()
                }
            }
        })
        return cell
    }
    
    
    func refresh (){
        trainingName.removeAll()
        trainingInfo.removeAll()
        refresher.endRefreshing()
        firebaseRead()
    }
    
    func firebaseRead(){
        
        
        databaseHandleNameTraining = ref?.child("Train").child(userTrainID).child(toWeekAbr).observe(.childAdded, with: { (snapshot) in
            self.trainingName.append(snapshot.key)
            self.trainingTableView.reloadData()
        })
    }
    
}
