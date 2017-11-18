//
//  Tela1 BoasVindas.swift
//  WorkFit
//
//  Created by IFCE on 16/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit

class Tela1_BoasVindas: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Ações Botão
    
    @IBAction func bEntrar(_ sender: UIButton) {
        

    }


    @IBAction func bCadastrar(_ sender: UIButton) {
       // performSegue(withIdentifier: "bcadastrar",sender: self)
        
    }

}
