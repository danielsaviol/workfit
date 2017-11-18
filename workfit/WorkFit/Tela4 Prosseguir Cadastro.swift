//
//  Tela4 Prosseguir Cadastro.swift
//  WorkFit
//
//  Created by Marllon Sóstenes on 27/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage


class Tela4_Prosseguir_Cadastro: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var sw1: UISwitch!
    @IBOutlet weak var sw2: UISwitch!
    @IBOutlet weak var bConcluir: UIButtonBorder!
    @IBOutlet weak var editSenha: TxtFieldImg!
    @IBOutlet weak var editRepetirSenha: TxtFieldImg!
    @IBOutlet weak var editPeso: TxtFieldImg!
    @IBOutlet weak var editAltura: TxtFieldImg!
    @IBOutlet weak var editBF: TxtFieldImg!
    @IBOutlet weak var bCarregaImg: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var emailtext = ""
    var nometext = ""
    var nascimentotext = ""
    var img = ""
    
    var originConstraintConstant : CGFloat = 0.0;
    
    var currentUserRef = FIRDatabaseReference()
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailtext = mail
        nometext = name
        nascimentotext = nasc
        
        //setupFirebaseObservers()
        
        self.navigationController?.isNavigationBarHidden = false
        
        editSenha.delegate = self
        editRepetirSenha.delegate = self
        editBF.delegate = self
        editAltura.delegate = self
        editPeso.delegate = self
        
        roundAndShowImage(img: imgView, str: "https://firebasestorage.googleapis.com/v0/b/workfit-27ade.appspot.com/o/pic%2F0.jpg?alt=media&token=8a2e5751-407c-4a43-86a2-f8339c973a61")
        
        editSenha.editConfig(image: "Password-20.png", position: true)
        editRepetirSenha.editConfig(image: "Password-20.png", position: true)
        editPeso.editConfig(image: "Weight-20.png", position: true)
        editAltura.editConfig(image: "Height-20.png", position: true)
        editBF.editConfig(image: "Torso Filled-20.png", position: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        originConstraintConstant = bottomConstraint.constant
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deregisterKeyboardListeners()
    }
    
    
    @IBAction func swPerderGordura(_ sender: UISwitch) {
        if sw1.isOn{
            sw2.isOn = false
        } else {
            sw2.isOn = true
        }
    }
    
    @IBAction func swGanharPeso(_ sender: UISwitch) {
        if sw2.isOn{
            sw1.isOn = false
        } else {
            sw1.isOn = true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == editPeso.self{
            editAltura.becomeFirstResponder()
        }
        if textField == editAltura.self{
            editBF.becomeFirstResponder()
        }
        if textField == editBF.self{
            editSenha.becomeFirstResponder()
        }
        if textField == editSenha.self{
            editRepetirSenha.becomeFirstResponder()
        }
        if textField == editRepetirSenha.self{
            editPeso.becomeFirstResponder()
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
    
    @IBAction func bConcluir(_ sender: UIButtonBorder) {
        if (editBF.text == "") || (editPeso.text == "") || (editSenha.text == "") || (editRepetirSenha.text == "") || (editAltura.text == "") {
            
            let alert = UIAlertController(title: "Atenção", message: "Insira todos os campos para concluir o cadastro", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            if editSenha.text == editRepetirSenha.text {
                handleEmailPasswordSignUp()
                self.saveChanges()
            } else {
                let alert = UIAlertController(title: "Atenção", message: "As senhas não coicidem!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        bottomConstraint.constant = keyboardSize.cgRectValue.height + 11
    }
    
    func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = originConstraintConstant
    }
    
    
    
    func handleEmailPasswordSignUp(){
        FIRAuth.auth()!.createUser(withEmail: emailtext, password: editSenha.text!, completion: {(user, error) in
            if error == nil{
                self.saveChanges()
                
            } else {
                let alert = UIAlertController(title: "Atenção", message: (error?.localizedDescription)! as String, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                print((error?.localizedDescription)! as String)
            }
        })
    }
    
    func roundAndShowImage(img: UIImageView, str: String) {
        img.loadImageUsingCacheWithUrlString(str)
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
    }
    
    func setupFirebaseObservers(){
        let firebaseRef = FIRDatabase.database().reference()
        let currentUserUid = FIRAuth.auth()!.currentUser!.uid
        currentUserRef = firebaseRef.child("Clients").child(currentUserUid)
        //currentUserRef.observe(.childAdded, with: {snapshot})
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageUrl          = info[UIImagePickerControllerReferenceURL] as? NSURL
        let imageName         = imageUrl?.lastPathComponent
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let photoURL          = URL(fileURLWithPath: documentDirectory)
        let localPath         = photoURL.appendingPathComponent(imageName!)
        var selectedImageFromPicker: UIImage?
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            imgView.image = selectedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveChanges(){
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "dd/MM/yyyy"
        //        var dates = dateFormatter.date(from: nascimentotext)
        //        dates = Calendar.dateComponents([.year], from: nascimentotext, to: dates)
        //        let age = dates.year!
        //
        let tmb1 = 370.0+(21.6*Float(editPeso.text!)!)
        let tmb2 = Float(editPeso.text!)!*Float(editBF.text!)!/100
        let taxa = Int(tmb1 - tmb2)
        
        //databaseRef
        
        if let users = FIRAuth.auth()?.currentUser {
            let uid = users.uid;
            self.databaseRef.child("Clients").child(uid).setValue(["email": users.email])
            userEmail = users.email!
            self.databaseRef.child("Clients").child(uid).updateChildValues(["altura": self.editAltura.text!])
            userAltura = self.editAltura.text!
            self.databaseRef.child("Clients").child(uid).updateChildValues(["bf": self.editBF.text!])
            userBF = self.editBF.text!
            self.databaseRef.child("Clients").child(uid).updateChildValues(["dietID": "0"])
            userDietID = "0"
            self.databaseRef.child("Clients").child(uid).updateChildValues(["trainID": "0"])
            userTrainID = "0"
            self.databaseRef.child("Clients").child(uid).updateChildValues(["tmb": "\(taxa)"])
            userTMB = "\(taxa)"
            self.databaseRef.child("Clients").child(uid).updateChildValues(["dietKcal": "0"])
            //            userDietKCAL = "0"
            self.databaseRef.child("Clients").child(uid).updateChildValues(["food alergicos": ""])
            self.databaseRef.child("Clients").child(uid).updateChildValues(["food especifications": ""])
            if self.sw1.isOn {
                self.databaseRef.child("Clients").child(uid).updateChildValues(["goal": "Perca de Gordura"])
                userObj = "Perca de Gordura"
            } else {
                self.databaseRef.child("Clients").child(uid).updateChildValues(["goal": "Ganho de Massa"])
                userObj = "Ganho de Massa"
            }
            self.databaseRef.child("Clients").child(uid).updateChildValues(["name": nometext])
            userName = nometext
            self.databaseRef.child("Clients").child(uid).updateChildValues(["peso": self.editPeso.text!])
            userPeso = self.editPeso.text!
            self.databaseRef.child("Clients").child(uid).updateChildValues(["levelAcess": "1"])
            userLevel = "1"
            
            let id = self.databaseRef.child("Train").childByAutoId().key
            let childUpdates = [ "\(id)" : ["musculo" : "Descanso", "dom": ["musculo" : "Descanso"], "seg" : ["musculo" : "Descanso"], "ter" : ["musculo" : "Descanso"], "qua" : ["musculo" : "Descanso"], "qui" : ["musculo" : "Descanso"], "sex" : ["musculo" : "Descanso"], "sab" : ["musculo" : "Descanso"] ] ]
            let idTrain = id
            self.databaseRef.child("Train").updateChildValues(childUpdates)
            //Insere o idTrain no campo de trainID
            let trainID = ["trainID" : idTrain ]
            self.databaseRef.child("Clients").child(uid).updateChildValues(trainID)
            
            let data = UIImagePNGRepresentation(self.imgView.image!)
            let storedImage = storageRef.child("pic").child(uid)
            
            storedImage.put(data!, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Atenção", message: "Um erro ocorreu ao fazer o upload da imagem. Selecione a imagem novamente.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                self.databaseRef.child("Clients").child(uid).updateChildValues(["pic": "\(metadata.downloadURL()!)"])
                userPic = "\(metadata.downloadURL()!)"
                self.performSegue(withIdentifier: "goToSelectCoach", sender: self)
                
            }
            
            UserDefaults.standard.set("1", forKey: "levelAcess")
            UserDefaults.standard.synchronize()
            //fim
            
        }
        
        
    }
}

