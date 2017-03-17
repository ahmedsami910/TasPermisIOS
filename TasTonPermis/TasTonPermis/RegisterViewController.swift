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
    
    @IBOutlet weak var userAgeField: UITextField!
    @IBOutlet weak var userLastNameField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    var context:NSManagedObjectContext?
    
    var datePickerView : UIDatePicker?
    var date: Date?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userRepeatPasswordField.delegate=self
         userPasswordField.delegate=self
         userNameField.delegate=self
         userNicknameField.delegate=self
         userLastNameField.delegate=self
         userAgeField.delegate=self
        
        addDatePickerView()
        
        //2
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
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
        newUser.setValue(Int(userAgeField.text!), forKey: "age")
        newUser.setValue(userNicknameField.text, forKey: "nickname")
        newUser.setValue(userPasswordField.text, forKey: "password")
            //print("User Ajouté" ,newUser)
        //newUser.setValue(userFiled, forKey: "age")
            
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
    
    @IBAction func OnKeyDown(_ sender: Any) {
        
    }
    
    func addDatePickerView(){
        datePickerView=UIDatePicker()
        datePickerView?.datePickerMode=UIDatePickerMode.date
        datePickerView?.addTarget(self, action: #selector(RegisterViewController.selectionDate(_sender:)), for: .valueChanged)
        
        userAgeField.inputView=datePickerView
    }
    
    func selectionDate(_sender: UIDatePicker){
        let dateformatter=DateFormatter()
        dateformatter.dateFormat = "dd/mm/yyy"
        userAgeField.text=dateformatter.string(from:_sender.date)
        date=_sender.date
    }
    
    
    
    func getAge(dateOfBirth: Date)->String{
        
        let currentDate = Date()
        let calendar = Calendar.current
        
        let cYear = calendar.component(.year, from: currentDate)
        let cMonth = calendar.component(.month, from: currentDate)
        let cDay = calendar.component(.day, from: currentDate)
        
        let year = calendar.component(.year, from: dateOfBirth)
        let month = calendar.component(.month, from: dateOfBirth)
        let day = calendar.component(.day, from: dateOfBirth)
        
        print("hours = \(year):\(month):\(day)")
        
        let age: Int = (cYear-year)+(cMonth-month)+(cDay-day)
        return "\(age)"
    }
    
    
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
