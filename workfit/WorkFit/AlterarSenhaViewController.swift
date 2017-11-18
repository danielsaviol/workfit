//
//  AlterarSenhaViewController.swift
//  WorkFit
//
//  Created by IFCE on 24/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AlterarSenhaViewController: UIViewController {
    
    
    var databaseHandle:FIRDatabaseHandle?
    var databaseHandleCoach:FIRDatabaseHandle?
    var nomeCoach = " "
    var senhaAtual = " "
    
    
    @IBOutlet weak var labelSenha: UILabel!
    
    @IBOutlet weak var labelNome: UILabel!
    @IBOutlet weak var textFieldSenhaAtual: UITextField!
    
    @IBOutlet weak var textFieldNovaSenha: UITextField!
    
    @IBOutlet weak var textFieldRepitaSenha: UITextField!
    
    
    @IBAction func btnSalvar(_ sender: Any) {
        
        let banco = FIRDatabase.database().reference()
        
        if textFieldSenhaAtual.text != nil && textFieldNovaSenha.text != nil {
            //Verifica se a senha eh igual a atual
            if textFieldSenhaAtual.text == senhaAtual {
                let childUpdates = ["senha": textFieldNovaSenha.text]
                banco.child("Coachs").child(nomeCoach).updateChildValues(childUpdates)
            }  else{
                exibirAlerta()
            }
            
            
        }
        
        if textFieldAlterarNome != nil{
            let childUpdates = ["name": textFieldAlterarNome.text]
            banco.child("Coachs").child(nomeCoach).updateChildValues(childUpdates)
        }
        
        
        
        
    }
    
    
    
    
    @IBOutlet weak var textFieldAlterarNome: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func buscandoSenhaCoach(){
        
        var banco = FIRDatabase.database().reference()
        
        databaseHandleCoach = banco.child("Coachs").child(nomeCoach).child("senha").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? String
            
            if let actualPost = post {
                self.senhaAtual = actualPost
                print(actualPost)
            }
            
        })
        
        
    }
    
    func exibirAlerta(){
        let alerta = UIAlertController(title: "Alerta", message: "Senha inválida", preferredStyle: UIAlertControllerStyle.alert);
        
        alerta.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil));
        
        self.present(alerta, animated: true, completion: nil);
    }
    
    
}
