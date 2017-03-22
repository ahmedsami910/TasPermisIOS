//
//  ProfilViewContoller.swift
//  TasTonPermis
//
//  Created by tp01 on 22/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit
import CoreData

class ProfilViewController: UIViewController {
    var globalData: NSDictionary?
    
    var idUserProfil: Int?
    
    var dateFormatStr = "DD/MM/YYYY"
    var appointments = [NSDictionary]()
    //var userData = [NSManagedObject]()

    var context = DBController.persistentContainer.viewContext
    
    @IBOutlet weak var AppointmentCells: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        putData("IdUser", 2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //getUserAppointment()
    }
    
    func fetchAppointment(_ predicate:String, completion :(_ array:NSArray) -> ()) {
        print("fetch")
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Appointment")
        request.predicate = NSPredicate(format: "idUser = %@", predicate)
        request.fetchLimit=1
        
        do {
            let results = try context.fetch(request)
            
            for result in results {
                print("trouvé")
                let idUser = (result as AnyObject).value(forKey: "idUser")!
                let firstname = (result as AnyObject).value(forKey: "firstname")
                let lastname = (result as AnyObject).value(forKey: "lastname")
                let grade = (result as AnyObject).value(forKey: "grade")
                let dateOfBirth = (result as AnyObject).value(forKey: "dateOfBirth") as! Date
                
                let userDict = ["idUser": idUser, "firstname": firstname, "lastname": lastname, "dateOfBirth": dateOfBirth, "grade": grade]
                
                appointments.append(userDict as NSDictionary)
                //userData.append(result as! NSManagedObject)
            }
            completion(appointments as NSArray)
        }catch {
            print("erreur requête")
        }
        print("out of getUser")
    }
    
    func putData(_ name: String, _ value: Any){
        //globalData[name]!=value
    }
    
}
