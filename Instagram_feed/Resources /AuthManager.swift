//
//  AuthManager.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/22/23.
//

import Foundation


import FirebaseAuth
import FirebaseDatabase
import FirebaseCoreInternal


public class AuthManager {
    
    static let shared = AuthManager()
    
    //Mark: - Public
    
    public func registerNewUser(username: String, email: String, password: String,completion: @escaping (Bool) -> Void){
        
        
        /*
         - check if username is available
         - check if email is available
         */
        
        
        DatabaseManager.shared.canCreateNewUser(with: email, username: username){ canCreate in
            if canCreate{
                
                /*
                 - Create account
                 -insert account into database
                 */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else{
                        return
                    }
                    
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email, username: username){
                        instered in
                        if instered{
                            completion(true)
                            return
                        }
                        
                        else{
                            completion(false)
                            return
                        }
                    }
                    
                }
            }
            else{
                
                // either username or email does not exist
                completion(false)
                
            }
        }
        
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
    
    /// logout Firebase User
    
    public func logOutUser(completion: @escaping (Bool) -> Void){
                do {
                    try Auth.auth().signOut()
                    completion(true)
                    return
                }
                catch{
                    print(error)
                    completion(false)
                    return
                }
    }
    
}
