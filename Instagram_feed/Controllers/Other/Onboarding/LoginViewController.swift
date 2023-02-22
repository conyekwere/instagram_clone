//
//  LoginViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let usernameEmailField: UITextField = {
        return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
          let button = UIButton()
        button.backgroundColor = .systemGray4
        return button
    }()
    
    
    private let createAccountButton: UIButton = {
          let button = UIButton()
        button.backgroundColor = .systemGray4
        return button
    }()
    
    
    private let termsButton: UIButton = {
        return UIButton()
    }()
    
    private let privacyButton: UIButton = {
          let button = UIButton()
        button.backgroundColor = .systemGray4
        return button
    }()
    
    private let headerView: UIView = {

        return UIView()
    }()
    
    
  

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames

        view.backgroundColor = .systemBackground
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
