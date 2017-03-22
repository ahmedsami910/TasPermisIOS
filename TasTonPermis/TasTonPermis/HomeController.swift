//
//  ViewController.swift
//  TasTonPermis
//
//  Created by tp01 on 16/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController ,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var context:NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          loginField.delegate=self
          passwordField.delegate=self
        // Do any additional setup after loading the view, typically from a nib.
            }
        
        
        
    @IBAction func loginPressed(_ sender: UIButton) {
        
       let  requete:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        //let fetchRequest = NSFetchRequest<User>()
       // requete.predicate = NSPredicate(format: "nickname = %@", loginField.text! )
        requete.predicate = NSPredicate(format: "nickname = %@", loginField.text!)
        
        // 3
        requete.returnsObjectsAsFaults = false

                do{
            
            let resultats =
                try context!.fetch(requete)
            
            if resultats.count > 0 {
                for resultat in resultats as! [NSManagedObject] { // 6
                    print(resultat.value(forKey: "nickname")!) // 7
                    if let passe = resultat.value(forKey: "password") as? String {
                        print(passe)
                        print("************************")
                        if(passe == passwordField.text){
                            print("utilisateur  ajouté")
                            let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "UserTableViewController")
                            self.navigationController!.pushViewController(VC1, animated: true)
                            self.present(VC1, animated:true, completion: nil)
                         
                       }
                   
                    }
                    
                }
            }
        }catch{
            print("ERREUR REQUETE ")
                        
                    }
    }
    
    func login(username : String , password :String )->Bool {
    
    
    return true 
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
   // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   }

