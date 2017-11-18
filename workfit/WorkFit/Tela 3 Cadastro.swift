//
//  Tela 3 Cadastro.swift
//  WorkFit
//
//  Created by IFCE on 16/02/17.
//  Copyright © 2017 Work Fit Team. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

var name = ""
var mail = ""
var nasc = ""

class Tela_3_Cadastro: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var editEmail: TxtFieldImg!
    @IBOutlet weak var editNasc: TxtFieldImg!
    @IBOutlet weak var editNome: TxtFieldImg!
    @IBOutlet weak var bProsseguir: UIButtonBorder!
    @IBOutlet weak var bottomConstraint2: NSLayoutConstraint!
    @IBOutlet weak var txtPassword: TxtFieldImg!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var originConstraintConstant : CGFloat = 0.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerKeyboardListeners()
        
        editEmail.delegate = self
        editNasc.delegate = self
        editNome.delegate = self
        self.navigationController?.isNavigationBarHidden = false
        
        editEmail.editConfig(image: "Message Filled_20.png", position: true)
        editNome.editConfig(image: "Gender Neutral User Filled_20.png", position: true)
        editNasc.editConfig( image: "Calendar Filled_20.png", position: true)

        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        let todayBtn = UIBarButtonItem(title: "Hoje", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.tappedToolBarBtn))
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 10)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Selecione seu nascimento"
        label.textAlignment = NSTextAlignment.center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        editNasc.inputAccessoryView = toolBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        originConstraintConstant = bottomConstraint.constant
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        deregisterKeyboardListeners()
    }
    
    func registerKeyboardListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(Tela_3_Cadastro.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(Tela_3_Cadastro.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.editEmail{
            editNome.becomeFirstResponder()
        }
        if textField == self.editNome{
            editNasc.becomeFirstResponder()
        }
        if textField == self.editNasc{
            editNome.becomeFirstResponder()
        }
        return true
    }
    
    func deregisterKeyboardListeners(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        bottomConstraint.constant = keyboardSize.cgRectValue.height
//        bottomConstraint2.constant = bottomConstraint.constant - 180
    }
    
    func keyboardWillHide(notification: Notification) {
        bottomConstraint.constant = originConstraintConstant
    }
    
    @IBAction func nascEditing(_ sender: TxtFieldImg) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        editNasc.text = dateFormatter.string(from: sender.date)
    }
    
    func donePressed(_ sender: UIBarButtonItem) {
        editNasc.resignFirstResponder()
    }
    
    func tappedToolBarBtn(_ sender: UIBarButtonItem) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/yyyy"
        editNasc.text = dateformatter.string(from: Date())
        editNasc.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

   
    @IBAction func bProsseguir(_ sender: UIButtonBorder) {
        if (editNasc.text == "") || (editNome.text == "") || (editEmail.text == ""){

            let alert = UIAlertController(title: "Atenção", message: "Insira todos os campos para prosseguir com o cadastro", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            name = editNome.text!
            mail = editEmail.text!
            nasc = editNasc.text!
           performSegue(withIdentifier: "goToCompleteRegister", sender: self)
            
        }
        
    }

  
}
