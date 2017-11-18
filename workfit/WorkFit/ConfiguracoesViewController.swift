//
//  ConfiguracoesViewController.swift
//  WorkFit
//
//  Created by IFCE on 16/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit

class ConfiguracoesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let idiomas = ["Português - PT", "English - EN"]
    
    @IBOutlet weak var labelNotificacoes: UILabel!
 
    @IBOutlet weak var pickerViewIdiomas: UIPickerView!
 
    var nomeCoach = " "
    
  
    @IBOutlet weak var switchNotificacoes: UISwitch!
    
    @IBOutlet weak var labelIdioma: UILabel!
   
   
    
   //Funcao de sair
    @IBAction func btnSair(_ sender: Any) {
        
        
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.1773306727, green: 0.1996578872, blue: 0.2513700724, alpha: 1)
        pickerViewIdiomas.dataSource = self
        pickerViewIdiomas.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
  
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return idiomas.count
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(idiomas[row])
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
        
        return idiomas[row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "forSegueAlterarSenha" {
            let destinationController = segue.destination as! AlterarSenhaViewController
            destinationController.nomeCoach = nomeCoach
            
        }
        
    }
    
    
    

    
}
