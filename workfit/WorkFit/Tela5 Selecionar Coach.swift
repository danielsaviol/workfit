
//
//  Tela5 Selecionar Coach.swift
//  WorkFit
//
//  Created by IFCE on 02/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class Tela5_Selecionar_Coach: UITableViewController {
    
    var refresher: UIRefreshControl!
    
   
    @IBOutlet var tableViewCoach: UITableView!
    
    var name = [String]()
    var pic = [String]()
    var idCoach = ""
    
    var ref:FIRDatabaseReference?
    var databaseHandleName:FIRDatabaseHandle?
    var databaseHandlePic:FIRDatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        //self.navigationItem.hidesBackButton = true
        
        ref = FIRDatabase.database().reference()
        firebaseRead()
        
        
        refresher = UIRefreshControl()
        refresher.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        refresher.addTarget(self, action: #selector(Tela5_Selecionar_Coach.refresh), for: UIControlEvents.valueChanged)
        tableViewCoach.addSubview(refresher)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //refresh()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pic.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCoachCell", for: indexPath) as! CoachCustomTableViewCell
        cell.setCoach(strImage: self.pic[indexPath.row], str: self.name[indexPath.row])
        
        return cell
        
    }
    
    
    // MARK : - Delegate Table View
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref?.child("Clients").child(userID!).updateChildValues(["coach": name[indexPath.row]])
        
        userCoach = name[indexPath.row]
        ref?.child("Clients").child(userID!).updateChildValues(["idCoach": idCoach])
        userCoachID = idCoach
        userCoachPic = pic[indexPath.row]
        
        self.performSegue(withIdentifier: "goToUserScreen", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToUserScreen" {
            //let userID = FIRAuth.auth()?.currentUser?.uid
            //ref?.child("Clients").child(userID).setValue(["coach": name[indexPath.row]])
            //salva no bd :
            //salva no bd: pic[indexPath.row]
        }
        
    }
    
    func refresh(){
        name.removeAll()
        refresher.endRefreshing()
        firebaseRead()
    }
    
    func firebaseRead(){
        ref?.child("Coachs").observe(.childAdded, with: { (snapshot) -> Void in
            //let post = snapshot.value as? Dictionary<String, Any>
            self.name.append(snapshot.key)
            self.ref?.child("Coachs").child(snapshot.key).child("pic").observe(.value, with: { (snapshot) -> Void in
                self.pic.append((snapshot.value as? String)!)
                self.tableViewCoach.reloadData()
            })
            
            self.ref?.child("Coachs").child(snapshot.key).child("id").observe(.value, with: { (snapshot) -> Void in
                self.idCoach = (snapshot.value as? String)!
            })

        }) { (error) in
            print(error.localizedDescription)
        }
       
    }

}
