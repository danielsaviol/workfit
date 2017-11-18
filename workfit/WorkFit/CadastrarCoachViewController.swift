//
//  CadastrarCoachViewController.swift
//  WorkFit
//
//  Created by Marllon Sóstenes on 10/03/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage


class CadastrarCoachViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var editEmail: TxtFieldImg!
    @IBOutlet weak var editNome: TxtFieldImg!
    @IBOutlet weak var editSenha: TxtFieldImg!
    @IBOutlet weak var imgView: UIImageView!
    
    var currentUserRef = FIRDatabaseReference()
    let databaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        editSenha.delegate = self
        editEmail.delegate = self
        editNome.delegate = self
        
        roundAndShowImage(img: imgView, str: "https://firebasestorage.googleapis.com/v0/b/workfit-27ade.appspot.com/o/pic%2F0.jpg?alt=media&token=8a2e5751-407c-4a43-86a2-f8339c973a61")


    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == editEmail.self{
            editNome.becomeFirstResponder()
        }
        if textField == editNome.self{
            editSenha.becomeFirstResponder()
        }
        if textField == editSenha.self{
            editEmail.becomeFirstResponder()
        }
        return true
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func roundAndShowImage(img: UIImageView, str: String) {
        img.loadImageUsingCacheWithUrlString(str)
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    @IBAction func carregaImg(_ sender: Any) {
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

    
    @IBAction func bSaveCoach(_ sender: UIButtonBorder) {
        if (editEmail.text == "") || (editSenha.text == "") || (editNome.text == "") {
            
            let alert = UIAlertController(title: "Atenção", message: "Insira todos os campos para concluir o cadastro", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
                handleEmailPasswordSignUp()
                self.saveChanges()
        }

    }
    
    
    func handleEmailPasswordSignUp(){
        FIRAuth.auth()!.createUser(withEmail: editEmail.text!, password: editSenha.text!, completion: {(user, error) in
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

    func saveChanges(){
        if let users = FIRAuth.auth()?.currentUser {
            let uid = users.uid;
            self.databaseRef.child("Clients").child(uid).setValue(["email": users.email])

            self.databaseRef.child("Clients").child(uid).updateChildValues(["id": uid])

            self.databaseRef.child("Clients").child(uid).updateChildValues(["Senha": self.editSenha.text!])

            self.databaseRef.child("Clients").child(uid).updateChildValues(["name": editNome.text!])

            self.databaseRef.child("Clients").child(uid).updateChildValues(["levelAcess": "2"])

            
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
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
        
    }


}
