//
//  DetailViewController.swift
//  TasTonPermis
//
//  Created by tp01 on 16/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var ide: Int=0
    @IBOutlet weak var id: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("l'identifiant est \(ide)")
        id?.text="\(ide)";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setId(ident: Int){
        print("fonction set\(ide)")
        ide=ident;
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
