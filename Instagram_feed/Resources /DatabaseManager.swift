//
//  DatabaseManager.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/22/23.
//

import FirebaseDatabase


public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    // Mark: - Public
    
    /// Check if username and email is available
    ///  - Parameters
    ///       -email: String respresting email
    ///       -username: String respresting username

    public func canCreateNewUser(with email: String, username: String, completion:(Bool) -> Void) {
        
        completion(true)
        
    }
    
    /// insert new user data to database
    ///  - Parameters
    ///       -email: String respresting email
    ///       -username: String respresting username
    ///       -completion: Asyc callback for result if database entry succeded
        
    public func insertNewUser(with email:String, username: String, completion: @escaping (Bool) -> Void)
    {
        
        let key = email.safeDatabaseKey()
        
        print(key)
        
        
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                //succeeded
                completion(true)
                return
            }
            else {
                //failed
                completion(true)
                return
            }
        }
    }
    
    //MARK : - Private
    /// Firebase doesn't except email adresses with @ values and .
    /// func safeDatabaseKey() in extetentions

    
}
