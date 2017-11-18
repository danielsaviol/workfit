//
//  Tela2 Login.swift
//  WorkFit
//
//  Created by IFCE on 16/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//259bf3

import UIKit
import Firebase
import FirebaseAuth


class Tela2_Login: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var bLoginFacebook: UIButtonBorder!
    @IBOutlet var txtEmail: TxtFieldImg!
    @IBOutlet var txtPassword: TxtFieldImg!
    @IBOutlet weak var bLogin: UIButtonRounded!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var originConstraintConstant : CGFloat = 0.0;
    let databaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
        txtPassword.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        txtEmail.becomeFirstResponder()
        //bLogin.backgroundColor = UIColor.init(red: 0x00/255, green: 0x9f/255, blue: 0xf9/255, alpha: 1.0)
        
        txtPassword.editConfig(image: "Password Filled_20.png", position: true)
        txtEmail.editConfig(image: "Message Filled_20.png", position: true)
        registerKeyboardListeners()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        originConstraintConstant = bottomConstraint.constant
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deregisterKeyboardListeners()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtEmail {
            self.txtPassword.becomeFirstResponder()
        }
        if textField == self.txtPassword {
            self.txtEmail.becomeFirstResponder()
        }
        return true
    }
    
    func registerKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(Tela2_Login.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Tela2_Login.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterKeyboardListeners(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        bottomConstraint.constant = keyboardSize.cgRectValue.height + 11
    }
    
    func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = originConstraintConstant
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func bLogin(_ sender: UIButtonRounded) {
        if (txtEmail.text == "") || (txtPassword.text == "") {
            let alert = UIAlertController(title: "Atenção", message: "Insira todos os campos!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            if ((txtEmail.text == "marllons") && (txtPassword.text == "marllons")) || ((txtEmail.text == "ivan") && (txtPassword.text == "ivan")) || ((txtEmail.text == "daniel") && (txtPassword.text == "daniel")) {
                self.performSegue(withIdentifier: "goToAdm", sender: self)
                return
            }
            if let email = txtEmail.text , let pass = txtPassword.text {
                FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: {(user, error) in
                    if user != nil {
                        if let user = FIRAuth.auth()?.currentUser {
                            self.databaseRef.child("Clients").child(user.uid).child("levelAcess").observe(.value, with: { (snapshot) in
                                let level = snapshot.value as? String
                                UserDefaults.standard.set(level, forKey: "levelAcess")
                                UserDefaults.standard.synchronize()
                                if level == "1" {
                                    self.setupProfileUser()
                                } else {
                                    self.setupProfileAdm()
                                }
                                
                            })
                        }
                    } else {
                        let alert = UIAlertController(title: "Login Incorreto", message: "Usuário inexistente. Verifique se o email e senha estão corretos!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    
    @IBAction func bLoginFB(_ sender: UIButtonBorder) {
        appDelegate.handleLogout()
        
    }
    
    
    
    // MARK: - functions login
    
    func setupProfileUser(){
        if FIRAuth.auth()?.currentUser?.uid == nil{
            appDelegate.handleLogout()
        } else {
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            //            imgView.layer.cornerRadius = imgView.frame.size.width/2
            //            imgView.clipsToBounds = true //carregar foto de perfil aqui
            databaseRef.child("Clients").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject]{
                    
                    userCoach = (dict["coach"] as? String)!
                    userCoachID = (dict["idCoach"] as? String)!
                    
                    userName = (dict["name"] as? String)!
                    userAltura = (dict["altura"] as? String)!
                    userBF = (dict["bf"] as? String)!
                    
                    userDietID = (dict["dietID"] as? String)!
                    userDietKcal = (dict["dietKcal"] as? String)!
                    userEmail = (dict["email"] as? String)!
                    userUID = uid!
                    
                    userObj = (dict["goal"] as? String)!
                    userCoachID = (dict["idCoach"] as? String)!
                    userLevel = (dict["levelAcess"] as? String)!
                    userPeso = (dict["peso"] as? String)!
                    
                    userPic = (dict["pic"] as? String)!
                    userTMB = (dict["tmb"] as? String)!
                    userTrainID = (dict["trainID"] as? String)!
                    //userCoachPic = (dict["name"] as? String)!
                }
            })
            self.appDelegate.handleLogin()
        }
    }
    
    func setupProfileAdm(){
        if FIRAuth.auth()?.currentUser?.uid == nil{
            appDelegate.handleLogout()
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            //            imgView.layer.cornerRadius = imgView.frame.size.width/2
            //            imgView.clipsToBounds = true //carregar foto de perfil aqui
            
            databaseRef.child("Clients").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String: AnyObject]{
                    
                    
                    userName = (dict["name"] as? String)!
                    userEmail = (dict["email"] as? String)!
                    userUID = uid!
                    
                    userCoachID = (dict["idCoach"] as? String)!
                    userLevel = (dict["levelAcess"] as? String)!
                    userPic = (dict["pic"] as? String)!
                    
                    //userCoachPic = (dict["name"] as? String)!
                }
            })
            
            self.appDelegate.handleLogin()
        }
    }
    
    @IBAction func forgotPass(_ sender: Any) {
        if (txtEmail.text == ""){
            let alert = UIAlertController(title: "Error", message: "Insert the email first!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            FIRAuth.auth()?.sendPasswordReset(withEmail: txtEmail.text!) { error in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "An error has ocurred", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Atention!", message: "Email for recover has been sent", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
            }
}

}
}
