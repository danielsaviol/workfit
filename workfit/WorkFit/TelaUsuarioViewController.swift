//
//  TelaUsuarioViewController.swift
//  WorkFit
//
//  Created by IFCE on 06/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

var idDiet = ""
var idTrain = ""


class TelaUsuarioViewController: UIViewController {
    
    var email : String = " "
    var name: String = " "
    
    
    
    @IBOutlet weak var labelUser: UILabel!
    @IBOutlet weak var labelID: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    let banco = FIRDatabase.database().reference()
    var databaseHandleDieta:FIRDatabaseHandle?
    var databaseHandleTreino:FIRDatabaseHandle?
    var databaseHandleClient:FIRDatabaseHandle?
    var databaseHandleTrainID:FIRDatabaseHandle?
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        labelUser.text = name
        labelEmail.text = email
        print(clienteID)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    @IBAction func btnTreino(_ sender: Any) {
        self.performSegue(withIdentifier: "forSegueTreino", sender: self)
    }
    
    
    @IBAction func btnDieta(_ sender: Any) {
        self.performSegue(withIdentifier: "forSegueDieta", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "forSegueDieta" {
            let destinationController = segue.destination as! RefeicoesViewController
            
            banco.child("Clients").child(clienteID).child("dietID").observe(.value , with: { (snapshot) in
                let post = snapshot.value as? String
                
                if let actualPost = post {
                    idDiet = actualPost
                    
                    
                    if idDiet == "0" {
                        
                        //Criando ChildbyAutoID da dieta
                        let id = self.banco.child("Diet").childByAutoId().key
                        let childUpdates = [ "\(id)" : " " ]
                        idDiet = id
                        self.banco.child("Diet").updateChildValues(childUpdates)
                        //Inserindo essa dieta no Client-Diet
                        let clientDiet = [ clienteID : idDiet]
                        self.banco.child("Client-Diet").updateChildValues(clientDiet)
                        //insere no Cliente o idClient
                        let insereNoCliente  = ["dietID" : idDiet]
                        self.banco.child("Clients").child(clienteID).updateChildValues(insereNoCliente)
                        
                    }
                    
                }
            })
        }
        
        if segue.identifier == "forSegueTreino" {
            
            let destinationController = segue.destination as! EditarTreinoViewController
            
            banco.child("Clients").child(clienteID).child("trainID").observe(.value , with: { (snapshot) in
                let post = snapshot.value as? String
                
                if let actualPost = post {
                    
                    idTrain = actualPost
                    
                    
                    if idTrain == "0" {
                        
//                        let id = self.banco.child("Train").childByAutoId().key
//                        let childUpdates = [ "\(id)" : ["musculo" : "Descanso", "dom": ["musculo" : "Descanso"], "seg" : ["musculo" : "Descanso"], "ter" : ["musculo" : "Descanso"], "qua" : ["musculo" : "Descanso"], "qui" : ["musculo" : "Descanso"], "sex" : ["musculo" : "Descanso"], "sab" : ["musculo" : "Descanso"] ] ]
//                        idTrain = id
//                        self.banco.child("Train").updateChildValues(childUpdates)
//                        //Insere o idTrain no campo de trainID
//                        let trainID = ["trainID" : idTrain ]
//                        self.banco.child("Clients").child(clienteID).updateChildValues(trainID)
                        //Enviando idTrain pra inserir valores do Treino
                        
                    }
                   
                    
                }
            })
            
            
            
        }
        
        
        
        
    }
    
    
    
}
