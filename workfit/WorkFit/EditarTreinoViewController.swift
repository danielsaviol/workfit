//
//  EditarTreinoViewController.swift
//  WorkFit
//
//  Created by IFCE on 06/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var dia = ""

class EditarTreinoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var idClient = ""
    
    @IBOutlet weak var tableViewDiasDeTreino: UITableView!
    
    var dias = ["Domingo", "Segunda-feira", "Terça-feira", "Quarta-Feira", "Quinta-feira", "Sexta-feira", "Sabado"]
    
    
    let banco = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        tableViewDiasDeTreino.delegate = self
        tableViewDiasDeTreino.dataSource = self
        print(idTrain)
        
    }
      
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dias.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = dias[indexPath.row]
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        cell?.textLabel?.text = dias[indexPath.row]
        dia = dias[indexPath.row]
        self.performSegue(withIdentifier: "forSegueAdicionarTreino", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "forSegueAdicionarTreino" {
//            let destinationController = segue.destination as! treinoViewController
//            
//            if let IndexPath = tableViewDiasDeTreino.indexPathForSelectedRow{
//                destinationController.dia = dias[IndexPath.row]
//                destinationController.idTrain = idTrain
//              
//            }
        }
        
    
    

    

    

}
