//
//  RegisterViewController.swift
//  TasTonPermis
//
//  Created by tp01 on 17/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var userRepeatPasswordField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var userNicknameField: UITextField!
    
    
    @IBOutlet weak var userLastNameField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    var context:NSManagedObjectContext?
    
    //var datePickerView = UIDatePicker()
    var date: Date?
  
    override func viewDidLoad() {
        super.viewDidLoad()
         context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        userRepeatPasswordField.delegate=self
         userPasswordField.delegate=self
         userNameField.delegate=self
         userNicknameField.delegate=self
         userLastNameField.delegate=self
         //userAgeField.delegate=self
     
        
       
        
             // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterBtn(_ sender: Any) {
        
        
        if(userPasswordField.text == userRepeatPasswordField.text){
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!)
 
        newUser.setValue(userNameField.text, forKey: "firstname")
        newUser.setValue(userLastNameField.text, forKey: "lastname")
        //newUser.setValue(userAgeField.text!, forKey: "age")
        newUser.setValue(userNicknameField.text, forKey: "nickname")
        newUser.setValue(userPasswordField.text, forKey: "password")
            print("User Ajouté" ,newUser)
            
            do {
                try context?.save()
                print("sauvegarde Reussie \(newUser)")
            } catch {
                print("erreur sauvegarde ")
            }
            
        }else{
        print("Password Doesn't match")
        }
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  

   
}
