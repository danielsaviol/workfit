//
//  AlimentacaoTableViewController.swift
//  WorkFit
//
//  Created by IFCE on 23/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AlimentacaoTableViewController: UITableViewController {
    
    var refresher: UIRefreshControl!
    
    @IBOutlet var dietTableView: UITableView!
    

    
    var hour = [String]()
    var diet = [String]()
    var nameRef = [String]()
    var ref:FIRDatabaseReference?
    var databaseHandleDiet:FIRDatabaseHandle?
    var databaseHandleHour:FIRDatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1755665541, green: 0.1990170777, blue: 0.2529973984, alpha: 1)
        
        ref = FIRDatabase.database().reference()
        firebaseRead()
        
        refresher = UIRefreshControl()
        refresher.tintColor = #colorLiteral(red: 0.1450980392, green: 0.6078431373, blue: 0.9529411765, alpha: 1)
        refresher.addTarget(self, action: #selector(AlimentacaoTableViewController.refresh), for: UIControlEvents.valueChanged)
        dietTableView.addSubview(refresher)
        
        
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
    
    
    
    // MARK : - DataSource Table View
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hour.count + 1
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "dietHour", for: indexPath) as! DietCustomCell
            cell.textLabel?.textColor = #colorLiteral(red: 0.9963582925, green: 1, blue: 0.9969385177, alpha: 1)
            cell.selectionStyle = .none
            cell.textLabel?.font = UIFont(name:"Helvetica Neue", size:20)
            hour.sort()
            for index in 1...hour.count+1{
                diet.append("ref" + String(index))
                nameRef.append("Refeição " + String(index))
            }
            cell.lbDiet.text = nameRef[indexPath.row-1]
            cell.lbHour.text = hour[indexPath.row-1]
            
            cell.viewBack.layer.cornerRadius = 15
            
            return cell
        }
    }
    
    
    
    
    
    // MARK : - Delegate Table View
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
        }
        else{
            self.performSegue(withIdentifier: "transicaoAlimentacao", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "transicaoAlimentacao" {
            let destinationController = segue.destination as! VisualizaAlimentacaoTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationController.toHour = hour[indexPath.row-1]
                destinationController.toDiet = diet[indexPath.row-1]
            }
            
        }
        
    }
    
    
    
    func refresh (){
        hour.removeAll()
        
        refresher.endRefreshing()
        firebaseRead()
    }
    
    func firebaseRead(){
        
        databaseHandleDiet = ref?.child("Diet").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? Dictionary<String, Any>
            if snapshot.key == userDietID {
                if let actualPost = post {
                    var readHour = [String]()
                    for key in actualPost.keys {
                        if key.contains("ref"){
                            readHour.append((actualPost[key] as! Dictionary<String, Any>)["hora"] as! String)
                        }
                    }
                    self.hour = readHour
                    self.hour.sort()
                    self.dietTableView.reloadData()
                }
            }
        })
        
    }
    
}
