//
//  AlimentosViewController.swift
//  WorkFit
//
//  Created by IFCE on 02/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase



class AlimentosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableAlimentos: UITableView!
    
    
    

   // var idClient = ""
   // var idDiet = ""
    var inform = [String]()
    var food = [String]()
    var foodDetail = [String]()
    var databaseHandle:FIRDatabaseHandle?
    var databaseAlimentos: FIRDatabaseHandle?
    var databaseHandleNameFood: FIRDatabaseHandle?
    var databaseHandleHorario: FIRDatabaseHandle?
    let banco = FIRDatabase.database().reference()
    
    
    @IBOutlet weak var horario: UILabel!
    @IBOutlet weak var textFielHorario: UITextField!
    @IBOutlet weak var labelHorario: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        tableAlimentos.delegate = self
        tableAlimentos.dataSource = self
        tableAlimentos.reloadData()
        
        let banco = FIRDatabase.database().reference()

        
        //Mudando horario
        
        databaseHandleHorario = banco.child("Diet").child(idDiet).child(refeicao).observe(.childAdded, with: { (snapshot) in
            if snapshot.key == ("hora"){
                self.labelHorario.text = snapshot.value as? String
            }
            
        })
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        inform.removeAll()
        food.removeAll()
        foodDetail.removeAll()
        firebaseRead()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func btnMudarHorario(_ sender: Any) {
        labelHorario.text = textFielHorario.text
        let childUpdates = [ "hora" : textFielHorario.text]
        banco.child("Diet").child(idDiet).child(refeicao).updateChildValues(childUpdates)
        
    }
    
    
    // MARK: UItableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath)
        cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.textLabel?.text = foodDetail[indexPath.row]
        return cell
    }
    
    
    //MARK: -UITableViewDelegate
    
    
    func firebaseRead(){
        
        databaseHandle = banco.child("Diet").child(idDiet).child(refeicao).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? Dictionary<String, Any>
            if let actualPost = post {
                var info = [String]()
                for key in actualPost.keys {
                    if key == "ID"{
                        info.append(actualPost[key] as! String)
                    }
                }
                for i in 0..<info.count {
                    self.databaseHandleNameFood = self.banco.child("Foods").child(info[i]).observe(.childAdded, with: { (snapshot) in
                        
                        let post = snapshot.value as? String
                        if let actualPost = post {
                            
                            self.foodDetail.append(actualPost)
                            self.tableAlimentos.reloadData()
                        }
                    })
                }
                
                self.inform = info
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forSegueAdiciona" {
            var destinationController = segue.destination as! AdicionaAlimentosViewController
//            destinationController.refeicao = refeicao
//            destinationController.idDiet = idDiet
            
        }
        
    }
    
    // MARK - Editando a celula para excluir alimento
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            let banco = FIRDatabase.database().reference()
            banco.child("Diet").child(idDiet).child(refeicao).child(foodDetail[indexPath.row]).removeValue();
            foodDetail.remove(at: indexPath.row)
            tableAlimentos.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            tableAlimentos.reloadData()
        }
        
    }
    
    
    
    
    
    
    
}
