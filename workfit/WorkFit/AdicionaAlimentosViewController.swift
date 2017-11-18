//
//  AdicionaAlimentosViewController.swift
//  WorkFit
//
//  Created by IFCE on 02/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AdicionaAlimentosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableViewAlimentos: UITableView!

    @IBOutlet weak var searchBarAlimentos: UISearchBar!
    
    
    
    var searchActive : Bool = false
    var todosAlimentos = [String]()
    var valoresAlimentos = [String]()
    //var idDiet = ""
    //var refeicao = ""
    var databaseHandle:FIRDatabaseHandle?
    var databaseAlimentos: FIRDatabaseHandle?
    let banco = FIRDatabase.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableViewAlimentos.delegate = self
        tableViewAlimentos.dataSource = self
        //searchBarAlimentos.delegate = self
        
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        let banco = FIRDatabase.database().reference()
            databaseHandle = banco.child("Alimentos").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.key as? String
            if let actualPost = post {
               self.todosAlimentos.append(actualPost)
               self.tableViewAlimentos.reloadData()
            }
        })
        
             
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todosAlimentos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = todosAlimentos[indexPath.row]
        return cell
    }
    //MARK: -UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        cell?.textLabel?.text = todosAlimentos[indexPath.row]
        //Adicionando a tabela
        let key = todosAlimentos[indexPath.row]
        
        
        databaseHandle = banco.child("Alimentos").child(key).observe(.childAdded, with: { (snapshot) in
            if snapshot.key == ("alimentID"){
                let childUpdates = [ key : ["ID" : String(snapshot.value as! Int), "quant" : "1"]]
                self.banco.child("Diet").child(idDiet).child(refeicao).updateChildValues(childUpdates)
            }
           
        })
        
    }
    
    
    
    
    
    
    
    
    

    
    
}
