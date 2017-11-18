//
//  RefeicoesViewController.swift
//  WorkFit
//
//  Created by IFCE on 02/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var refeicao = ""

class RefeicoesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
  
    var refeicoes = ["ref1", "ref2", "ref3", "ref4", "ref5", "ref6", "ref7"]
    
    var databaseRefeicoes:FIRDatabaseHandle?
    
    
    @IBOutlet weak var tableViewRefeicoes: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        //let banco = FIRDatabase.database().reference()
        tableViewRefeicoes.delegate = self
        tableViewRefeicoes.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = refeicoes[indexPath.row]
        return cell
    }
    
    
    //MARK: -UITableViewDelegate
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        cell?.textLabel?.text = refeicoes[indexPath.row]
        
        refeicao = refeicoes[indexPath.row]
        
        self.performSegue(withIdentifier: "forSegueAlimentos", sender: self)
        
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "forSegueAlimentos" {
//            let destinationController = segue.destination as! AlimentosViewController
//            if let IndexPath = tableViewRefeicoes.indexPathForSelectedRow{
//                destinationController.refeicao = refeicoes[IndexPath.row]
//                destinationController.idDiet = idDiet
//                destinationController.idClient = idClient
//            }
//            
//        }
//        
//    }
//    
    
    
    
    
    
}
