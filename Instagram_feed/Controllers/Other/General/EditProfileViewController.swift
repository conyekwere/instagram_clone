//
//  EditProfileViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/22/23.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}
class EditProfileViewController: UIViewController, UITableViewDataSource{

    
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(UITableViewCell.self,
                               forCellReuseIdentifier:"cell")
            return tableView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    private func configureModels() {

    }
    // MARK : - Tableview
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
    
    // MARK : - Action
    
    @objc private func didTapSave(){
        dismiss(animated: true,
                    completion: nil)
    }
    @objc private func didTapCancel(){
        dismiss(animated: true,
                    completion: nil)
    }
    @objc private func didTapChangeProfilePicture(){
        let actionsheet = UIAlertController(title: "Profile Picture", message: "Change Profile picture", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{ _ in }))
        actionsheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler:{ _ in }))
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        
        actionsheet.popoverPresentationController?.sourceView = view
        actionsheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionsheet,animated: true)
    }
}


//extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data[section].count
//    }
//
//}
