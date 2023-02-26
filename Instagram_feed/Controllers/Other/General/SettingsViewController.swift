//
//  SettingsViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/22/23.
//

import UIKit


struct SettingCellModel{
    let title: String
    let handler: (() -> Void)
    
}


/// view controller to show user settings

final class SettingsViewController: UIViewController {
    
    
    private  let tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        
        tableView.layer.cornerRadius = Constants.cornerRadius
        tableView.backgroundColor = .secondarySystemBackground
        tableView.layer.borderWidth = 1.0
        tableView.layer.borderColor = UIColor.secondaryLabel.cgColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    private func addSubviews(){
        view.addSubview(tableView)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //assign frames on subview init
        tableView.frame =  view.bounds
        
        
    }
    
    
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections in the table view
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell and set its text label to the row number
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Row \(indexPath.row)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected row \(indexPath.row)")
    }
}



