//
//  ProfileViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    var emailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        // Create a UILabel and add it to the view
              emailLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
              emailLabel.center = CGPoint(x: view.center.x, y: view.center.y - 50)
              emailLabel.textAlignment = .center
              view.addSubview(emailLabel)
              
              // Retrieve the current user's email from Firebase Authentication
              if let currentUser = Auth.auth().currentUser {
                  emailLabel.text = currentUser.email
              }
        else{
            
            emailLabel.text = "no email found "
        }
        
    }
    
     private func configureNavigationBar(){
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))
        
    }
    
    @objc private func didTapSettingsButton(){
        
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
