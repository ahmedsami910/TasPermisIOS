//
//  LoginManager.swift
//  TasTonPermis
//
//  Created by tp32 on 21/03/2017.
//  Copyright © 2017 M2info. All rights reserved.
//

import Foundation


class LoginManager{

   var  isLoggedIn = false
    
    
    func login(username :String , password :String ) ->Bool {
        if (username != ""  && password != "") {
        
          isLoggedIn = true
            return true
            
        
        }else {
        
        isLoggedIn = false
        return false
        }
    
    
    }
    
    static let sharedIstance = LoginManager()
    

    
     private init() {
    
    
    
    }


}
