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
    let dateFormatString = "dd/MM/yyyy"
    var datePickerView : UIDatePicker?
    var dateOfBirth: Date?
  
    override func viewDidLoad() {
        super.viewDidLoad()
         context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        userRepeatPasswordField.delegate=self
         userPasswordField.delegate=self
         userNameField.delegate=self
         userNicknameField.delegate=self
         userLastNameField.delegate=self
         //userAgeField.delegate=self
     
        
       
        userPasswordField.delegate=self
        userNameField.delegate=self
        userNicknameField.delegate=self
        userLastNameField.delegate=self
        userAgeField.delegate=self
        
        addDatePickerView()
        
        dateOfBirth = dateFromStr(userAgeField.text!) as Date
        //2
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
             // Do any additional setup after loading the view.
    }
    
    //MARK - Format Date
    
    func formatterDate(date: Date) -> String {
        
        var dateStr:String?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = dateFormatString
        dateStr = dateFormatter.string(from: date)
        
        return dateStr!
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func RegisterBtn(_ sender: Any) {
        
        
        userAgeField.text="12/10/1991"
        dateOfBirth = dateFromStr(userAgeField.text!) as Date
        
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!)
 
        newUser.setValue(userNameField.text, forKey: "firstname")
        newUser.setValue(userLastNameField.text, forKey: "lastname")
        //newUser.setValue(userAgeField.text!, forKey: "age")
        
       // if( userNicknameField.text !="" && userNameField.text!="" && userLastNameField.text != ""
            
        
            if(userPasswordField.text == userRepeatPasswordField.text  ){
        
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!)

            
            
        newUser.setValue(userNameField.text, forKey: "firstname")
        newUser.setValue(userLastNameField.text, forKey: "lastname")
        newUser.setValue( dateOfBirth, forKey: "age")
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

    
    func dateFromStr(_ dateStr: String) -> Date {

        let formatter  = DateFormatter()
        formatter.dateFormat  = "dd/mm/yyyy"
        
        return formatter.date(from: dateStr)!
        
        //return date
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
        dateOfBirth=_sender.date
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
    
  

   
}
