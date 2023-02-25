//
//  RegistrationViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/21/23.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    
    struct Constants{
        static let cornerRadius: CGFloat = 8.0
        static let inputHeight: CGFloat = 52.0
    }
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        // on keyboard say continue
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address..."
        // on keyboard say continue
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        // on keyboard say continue
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray4
        button.setTitle("Sign up ", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        //        button.backgroundColor = .systemGray4
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        button.configuration = UIButton.Configuration.borderless()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.setTitle("Terms of Service ", for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 8)
        button.configuration = UIButton.Configuration.borderless()
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        button.setTitle("Privacy Policy ", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "ig-bg"))
        header.addSubview(backgroundImageView)
        //        header.backgroundColor = .red
        return header
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        addSubviews()
        view.backgroundColor = .systemBackground
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames on subview init

        
        usernameField.frame = CGRect(
            x:20,
            y: view.safeAreaInsets.top + 100,
            width: view.width - 40,
            height: Constants.inputHeight
        )
        
        
        emailField.frame = CGRect(
            x:20,
            y: usernameField.bottom + 10,
            width: view.width - 40,
            height: Constants.inputHeight
        )
        
        
        passwordField.frame = CGRect(
            x:20,
            y: emailField.bottom + 10,
            width: view.width - 40,
            height: Constants.inputHeight
        )
        
        registerButton.frame = CGRect(
            x:20,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 40,
            height: Constants.inputHeight
        )
    
        
        view.backgroundColor = .systemBackground
    }
    

    
    

    private func addSubviews(){
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)

    }
    
    @objc private func didTapRegisterButton(){
        //dismiss input
        passwordField.resignFirstResponder()
        emailField.resignFirstResponder()
        usernameField.resignFirstResponder()
        
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8  else
              {
                  return
              }
        
        
//        var usernameType: String?
//        var emailType: String?
//
//        // login  functionality
//        if username.contains("@"), username.contains(".") {
//            //email
//            emailType = username
//        }
//        else{
//            //username
//            usernameType = username
//        }
        
        AuthManager.shared.loginUser(username:username,email: email,password: password) { success in
            
            DispatchQueue.main.async {
                if success {
                    //user logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else{
                    // an error occurred
                    let alert =  UIAlertController(title:"Log in Error",
                                                   message: "We were unable to log you in.",
                                                   preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Dismiss",
                                                  style: .cancel,
                                                 handler: nil))
                    self.present(alert, animated: true )
                }
                
                
            }

        }
//        let vc = HomeViewController()
//        present(vc, animated: true)
    }

     
    
}

// create a modification on UIfield when user taps return move to next item

extension RegistrationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapRegisterButton()
        }
        return true
    }


}
