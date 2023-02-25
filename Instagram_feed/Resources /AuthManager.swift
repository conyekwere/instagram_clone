//
//  AuthManager.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/22/23.
//

import Foundation


import FirebaseAuth
import FirebaseDatabase


public class AuthManager {
    
    static let shared = AuthManager()
    
    //Mark: - Public
    
    public func registerNewUser(username: String, email: String, password: String){
        
    }
    // escaping  we put the completion inside another closure and the scope completion(true) needs to live in a different location as well
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
        if  let email = email {
            Auth.auth().signIn(withEmail: email, password: password){
                authResult, error in guard authResult != nil,error == nil else{
                    completion(false)
                    return
                    // if error
                    
                }
                completion(true)
            }
        }
        else if let username = username {
            // username login 
            print(username)
            
        }
        
    }
    
}
