//
//  FichaDeTreinoTableViewController.swift
//  WorkFit
//
//  Created by IFCE on 08/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FichaDeTreinoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var idTrain = ""
    var treino =  ""
    var idClient = ""
    
    var treinoDetail = [String]()
    var databaseHandleTraining:FIRDatabaseHandle?
    var databaseHandleNameTraining:FIRDatabaseHandle?
    let banco = FIRDatabase.database().reference()

    
    
    
    @IBOutlet weak var tableViewTreino: UITableView!
    
    @IBOutlet weak var textFieldTreinoDoDia: UITextField!
    
    @IBOutlet weak var btnMudarTreino: UIButton!
    
    @IBOutlet weak var labelTreinoDoDia: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   //MARK - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treinoDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = treinoDetail[indexPath.row]
        return cell
    }
    
    
    
    // MARK - Editando a celula para excluir alimento
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //Removendo
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            let banco = FIRDatabase.database().reference()
            banco.child("Train").child(idTrain).child(treinoDetail[indexPath.row]).removeValue();
            treinoDetail.remove(at: indexPath.row)
            tableViewTreino.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            tableViewTreino.reloadData()
            
            
        }
        
    }
    
    func firebaseRead(){
        
         databaseHandleNameTraining = banco.child("Train").child(userTrainID).child(dia).observe(.childAdded, with: { (snapshot) in
            self.treinoDetail.append(snapshot.key)
            self.tableViewTreino.reloadData()
        })
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forSegueAdiciona" {
            let destinationController = segue.destination as! EditarTreinoViewController
            // destinationController.refeicao = refeicao
            // destinationController.idDiet = idDiet
            
        }
        
    }
    
    
    
    
    
}
