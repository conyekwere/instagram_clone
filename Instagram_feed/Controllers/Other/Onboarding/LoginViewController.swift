//
//  LoginViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//
import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants{
        static let cornerRadius: CGFloat = 8.0
        static let inputHeight: CGFloat = 52.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
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
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray4
        button.setTitle("Log in ", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
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
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        addSubviews()
        view.backgroundColor = .systemBackground
        
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames on subview init
        headerView.frame = CGRect(
            x:0,
            y:0.0,
            width: view.width,
            height: view.height/3.0)
 
        
        // to move below staus bar  y: view.safeAreaInsets.top
        
        
        usernameEmailField.frame = CGRect(
            x:25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: Constants.inputHeight
        )
        
        
        passwordField.frame = CGRect(
            x:25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: Constants.inputHeight
        )
        
        loginButton.frame = CGRect(
            x:25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: Constants.inputHeight
        )
        
        createAccountButton.frame = CGRect(
            x:25,
            y: loginButton.bottom + 10,
            width: view.width - 50,
            height: Constants.inputHeight
        )
        
        termsButton.frame = CGRect(
            x:10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width - 20,
            height: Constants.inputHeight
        )
        
        privacyButton.frame = CGRect(
            x:10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width - 20,
            height: Constants.inputHeight
        )
        
        view.backgroundColor = .systemBackground
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else {
            
            return
        }
        //
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        // add ig logo
        let ImageView = UIImageView(image: UIImage(named: "instagram-text-logo"))
        headerView.addSubview(ImageView)
        ImageView.contentMode = .scaleAspectFit
        ImageView.frame = CGRect(
            x: headerView.width/4.0,
            y: view.safeAreaInsets.top ,
            width: headerView.width/2.0,
            height: headerView.height - view.safeAreaInsets.top
        )
    }
    
    

    private func addSubviews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton(){
        //dismiss input
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()

    
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8  else {
                  return
              }
        
        
        var username: String?
        var email: String?
        
        // login  functionality
        if usernameEmail.contains("@"), usernameEmail.contains(".") {
            //email
            email = usernameEmail
        }
        else{
            //username
            username = usernameEmail
        }
        
        AuthManager.shared.loginUser(username:username,email: email, password: password) { success in
            
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


    @objc private func didTapTermsButton(){
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    @objc private func didTapPrivacyButton(){
        guard let url = URL(string: "https://privacycenter.instagram.com/policy") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton(){
        let vc = RegistrationViewController()
        vc.title = "Create Account "
        present(UINavigationController(rootViewController: vc), animated: true)
        

    }
    
}

// create a modification on UIfield when user taps return move to next item

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
    
}

