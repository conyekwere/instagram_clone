//
//  LoginViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants{
        
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username or Email..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0, y: 0, width: 10, height:0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.cornerRadius = Constants.cornerRadius
        field.isSecureTextEntry = true
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray4
        button.setTitle("Log in ", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGray4
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
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
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
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames
        headerView.frame = CGRect(
            x:0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: view.height/3.0)
        //UIScreen.main.bounds.height
        view.backgroundColor = .systemBackground
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else {
            
            return
        }
        
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        
        backgroundView.frame = headerView.bounds
        // add ig logo
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
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
    
    @objc private func didTapLoginButton(){}
    @objc private func didTapTermsButton(){}
    @objc private func didTapPrivacyButton(){}
    @objc private func didTapCreateAccountButton(){}
    
}
