
//  UserTableViewController.swift
//  TasTonPermis
//
//  Created by tp01 on 16/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit
import CoreData

class UserTableViewController: UITableViewController{
    
    var id:[Int]=[0,1,2]
    var users = ["jeremy", "samy", "thomas"]
    var type = ["moniteur", "student", "monitor"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("je suis chargé")
       //if ( LoginManager.sharedIstance.isLoggedIn == false )
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "User", for: indexPath)
        //cell.textLabel?.text="Section\(indexPath.section)Row\(indexPath.row)"
        cell.textLabel?.text=users[indexPath.row]
        cell.detailTextLabel?.text=type[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Utilisateurs \(section)"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "UserDetail", sender: self)
        print("ok")
    }
    
    
    //passer en parametre l'identifiant
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("j'envoi l'id")
        if segue.identifier == "UserDetail" {
            print("condition 1")
            if let indexPath = self.tableView.indexPathForSelectedRow {
                print("condition 2")
                let controller = segue.destination as! DetailViewController
                //controller.ide=id[indexPath.row]
                controller.setId(ident: id[indexPath.row])
            }
        }
    }
}
