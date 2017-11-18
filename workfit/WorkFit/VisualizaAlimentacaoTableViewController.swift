//
//  VisualizaAlimentacaoTableViewController.swift
//  WorkFit
//
//  Created by Daniel on 01/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import UICircularProgressRing

class VisualizaAlimentacaoTableViewController: UITableViewController {
    
    var refresher: UIRefreshControl!
    
    
    @IBOutlet var foodTableView: UITableView!
    
    
    var toHour = ""
    var toDiet = ""
    var foodCount = [String]()
    var inform = [String]()
    var food = [String]()
    var foodDetail = [String]()
    var ref:FIRDatabaseReference?
    var databaseHandleFood:FIRDatabaseHandle?
    var databaseHandleQuantFood:FIRDatabaseHandle?
    var databaseHandleValues:FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1755665541, green: 0.1990170777, blue: 0.2529973984, alpha: 1)
        
        self.title = toHour
        
        ref = FIRDatabase.database().reference()
        firebaseRead()
        
        refresher = UIRefreshControl()
        refresher.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        refresher.addTarget(self, action: #selector(AlimentacaoTableViewController.refresh), for: UIControlEvents.valueChanged)
        foodTableView.addSubview(refresher)
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
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodCount.count-5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myFood", for: indexPath) as! FoodCustomCell
        cell.textLabel?.textColor = #colorLiteral(red: 0.9963582925, green: 1, blue: 0.9969385177, alpha: 1)
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont(name:"Helvetica Neue", size:20)
        cell.lbFood.text = foodCount[indexPath.row]
        databaseHandleQuantFood = ref?.child("Diet").child(userDietID).child(toDiet).child(foodCount[indexPath.row]).observe(.childAdded, with: { (snapshot) in
            if snapshot.key == "quant" {
                cell.lbNum.text = snapshot.value as! String?
            }
            if snapshot.key == "ID" {
                self.databaseHandleValues = self.ref?.child("Foods").child((snapshot.value as! String?)!).observe(.childAdded, with: { (snapshot) in
                    var value = Float()
                    if snapshot.key == "CARB" {
                        value = snapshot.value as! Float
                        cell.ringCarb.value = CGFloat(value)
                    }
                    if snapshot.key == "FAT" {
                        value = snapshot.value as! Float
                        cell.ringFat.value = CGFloat(value)
                    }
                    if snapshot.key == "KCAL" {
                        value = snapshot.value as! Float
                        cell.ringKcal.value = CGFloat(value)
                    }
                    if snapshot.key == "PROT" {
                        value = snapshot.value as! Float
                        cell.ringProt.value = CGFloat(value)
                    }
                })
            }
        })
        return cell
    }
    
    
    func refresh (){
        foodCount.removeAll()
        food.removeAll()
        inform.removeAll()
        foodDetail.removeAll()
        refresher.endRefreshing()
        firebaseRead()
    }
    
    func firebaseRead(){
        
        databaseHandleFood = ref?.child("Diet").child(userDietID).child(toDiet).observe(.childAdded, with: { (snapshot) in
            self.foodCount.append(snapshot.key)
            self.foodTableView.reloadData()
            
        })
        
    }
    
    
}
