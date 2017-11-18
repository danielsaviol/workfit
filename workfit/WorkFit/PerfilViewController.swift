//
//  PerfilViewController.swift
//  WorkFit
//
//  Created by IFCE on 16/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class PerfilViewController: UIViewController {
    
    
    var databaseHandle:FIRDatabaseHandle?
    var databaseHandleCoach:FIRDatabaseHandle?
    var databaseEmail:FIRDatabaseHandle?
    var databaseHandleName:FIRDatabaseHandle?
    
    //Pegar esse  ID ao se logar
    var idCoach = "e8mbKsK2g5VxDonGwZaIr7DFLUx1"
    var nomeCoach = ""
    var idadeCoach = ""
    var emailCoach = ""
    var cidadeCoach = ""
    
    
    
    @IBOutlet weak var imagemPerfil: UIImageView!
    
    @IBOutlet weak var nomePerfil: UILabel!
    
    @IBOutlet weak var emailPerfil: UILabel!
    
    @IBOutlet weak var cidadePerfil: UILabel!
    
    @IBOutlet weak var idadePerfil: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        buscandoInformacoesCoach()
        roundAndShowImage(img: imagemPerfil, str: "https://firebasestorage.googleapis.com/v0/b/workfit-27ade.appspot.com/o/pic%2F0.jpg?alt=media&token=8a2e5751-407c-4a43-86a2-f8339c973a61")
    }
    
    func roundAndShowImage(img: UIImageView, str: String) {
        img.loadImageUsingCacheWithUrlString(str)
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
    }
    
    func buscandoInformacoesCoach(){
        
        var banco = FIRDatabase.database().reference()
        
        databaseHandleCoach = banco.child("Coachs").observe(.childAdded, with: { (snapshot) in
            
            let post = snapshot.value as? Dictionary<String, Any>
            
            if let actualPost = post {
                
                for key in actualPost.keys {
                    
                    if key == "id" {
                        
                        let coach = actualPost[key] as? String
                        if self.idCoach == coach{
                            self.nomeCoach = snapshot.key
                            self.nomePerfil.text = self.nomeCoach
                        }
                        
                    }
                    if key == "age"{
                        var idade = actualPost[key] as? String
                        self.idadeCoach = idade!
                        self.idadePerfil.text = self.idadeCoach
                    }
                    if key == "email"{
                        var email = actualPost[key] as? String
                        
                        self.emailCoach = email!
                        self.emailPerfil.text = self.emailCoach
                    }
                    if key == "cidade"{
                        var cidade = actualPost[key] as? String
                        self.cidadeCoach = cidade!
                        self.cidadePerfil.text = self.cidadeCoach
                        
                    }
                }
                
                
            }
            
        })
        
        
    }
    
    
    
}
