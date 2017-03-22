//
//  DetailViewController.swift
//  TasTonPermis
//
//  Created by tp01 on 16/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var idUserPage: Int=1

    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var grade: UILabel!
    
    var dateFormatStr = "DD/MM/YYYY"
    var user = [NSDictionary]()
    var userData = [NSManagedObject]()
    
    var context = DBController.persistentContainer.viewContext
    
    @IBOutlet weak var id: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("l'identifiant est \(idUserPage)")
        id?.text="\(idUserPage)";
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        cleanTable(entity: "User", predicate: "")
        addExample()
        getUserData()
        initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setId(ident: Int){
        print("fonction set\(idUserPage)")
        idUserPage=ident;
        print("id est maintenant \(idUserPage)")
    }
    
    
    func getUserData(){
        print("getUserData")
        fetchUser("\(idUserPage)") { (user, userData) in
            print(user)
            print(userData)
        }
        print(user[0]["firstname"]!)
        print(userData[0].value(forKey: "lastname")!)
    }
    
    func fetchUser(_ predicate:String, completion :(_ array:NSArray,_ arrayData:NSArray) -> ()) {
        print("fetch")
        //var user = [NSDictionary]()
        //var userData = [NSManagedObject]()
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
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
                
                user.append(userDict as NSDictionary)
                userData.append(result as! NSManagedObject)
            }
        completion(user as NSArray, userData as NSArray)
        }catch {
            print("erreur requête")
        }
        print("out of getUser")
    }
    
    func initView(){
        firstname.text="prénom :\(user[0]["firstname"]!)"
        lastname.text="nom :\(user[0]["lastname"]!)"
        //age.text="age :\(calculateAge(user[0].value(forKey: "dateOfBirth") as! Date))"
        age.text="age :\(calculateAge(user[0]["dateOfBirth"] as! Date))"
        grade.text="note :\(user[0]["grade"]!)"
        
    }
    
    func calculateAge(_ dateOfBirth: Date) -> String {
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.day, .month, .year], from: dateOfBirth, to: currentDate )
        let dayString = "\(components.day!)"
        let monthString = "\(components.month!)"
        let yearString = "\(components.year!)"
        
        
        //var dc = DateComponents(); dc.year = year; dc.month = month; dc.day = day
        //let cal = Calendar.current
        //return cal.date(from: dc)! as NSDate
        return yearString
    }
    
    func addExample(){
        let newUser : User = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        newUser.firstname = "Durand"
        newUser.lastname = "Albert"
        newUser.idUser=1
        newUser.grade=2.5
        newUser.type="student"
        
        newUser.dateOfBirth = date(year: 1980, month: 02, day: 10)
        do {
            try context.save()
            print("sauvegarde aboutie pour \(newUser)")
        } catch {
            print("erreur sauvegarder au Model")
        }
    }
    
    func cleanTable(entity: String, predicate: String){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        if(predicate==""){
            do{
                let result = try context.execute(request)
            } catch{
                print("erreur requête")
            }
        }else{
        
        }
    }
    
    func formatterDate(_ date:Date) -> String {
        
        var dateStr:String?
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = dateFormatStr
        dateStr = dateFormatter.string(from: date)
        
        return dateStr!
    }
    
    func dateFromStr(_ dateStr: String) -> Date {
        
        let formatter  = DateFormatter()
        formatter.dateFormat  = dateFormatStr
        let date = formatter.date(from: dateStr)
        
        return date!
    }
    
    private func date(year: Int, month: Int, day: Int) -> NSDate {
        var dc = DateComponents(); dc.year = year; dc.month = month; dc.day = day
        let cal = Calendar.current
        return cal.date(from: dc)! as NSDate
    }
}
