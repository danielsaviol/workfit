//
//  UsuariosViewController.swift
//  WorkFit
//
//  Created by IFCE on 16/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var clienteID = ""

class UsuariosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var idClients = [String]()
    var nomeUsuarios = [String]()
    var emailUsuarios = [String]()
    var databaseHandle:FIRDatabaseHandle?
    var databaseHandleID:FIRDatabaseHandle?
    var databaseHandleName:FIRDatabaseHandle?
    var databaseHandleClients:FIRDatabaseHandle?
    //Pegar esse ID ao se logar
    var idCoach = userCoachID
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        tableViewUsuarios.delegate = self
        tableViewUsuarios.dataSource = self
        
        //Pegando email e nome
        firebaseRead()
        buscarEmailNomes()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var tableViewUsuarios: UITableView!
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idClients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = idClients[indexPath.row]
        return cell
    }
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        
        cell?.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        cell?.textLabel?.text = idClients[indexPath.row]
        clienteID = idClients[indexPath.row]
        self.performSegue(withIdentifier: "forSegueTelaUsuario", sender: self)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    
    
    
    
    func buscarEmailNomes(){
        
        for index in idClients {
            
            
            let banco = FIRDatabase.database().reference()
            
            databaseHandleID = banco.child("Clients").child(index).observe(.childAdded, with: { (snapshot) in
                
                let post = snapshot.value as? Dictionary<String, Any>
                
                if let actualPost = post {
                    
                    for key in actualPost.keys {
                        
                        if (key == "name"){
                            self.nomeUsuarios.append((actualPost[key] as? String)!)
                        }
                        
                        if( key == "email"){
                            self.emailUsuarios.append((actualPost[key] as? String)!)
                        }
                        
                    }
                    self.tableViewUsuarios.reloadData()
                }
            })
            
        }
        
        
        
        
    }
    
    
    
    func firebaseRead(){
        var banco = FIRDatabase.database().reference()
        databaseHandleID = banco.child("Clients").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? Dictionary<String, Any>
            
            if let actualPost = post {
                
                for key in actualPost.keys {
                    
                    if (key == "idCoach"){
                        self.idClients.append(snapshot.key)
    
                        
                    }
                    
                }
                self.tableViewUsuarios.reloadData()
            }
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
