//
//  NotificationsViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    // lazy meaning only init if called
    private lazy var noNotificationsView = NoNotificationsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        //spinner.startAnimating()
        view.addSubview(tableView)
        addNoNotificationsView()
        tableView.delegate = self
        tableView.dataSource  = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100).integral
        spinner.center = view.center
    }
    private func addNoNotificationsView(){

        if 1+1 == 3{
            tableView.isHidden = true
            view.addSubview(noNotificationsView)
            noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/3)
            noNotificationsView.center = view.center
        }
    
   
    }
    
    func tableView(_ tableView: UITableView,  numberOfRowsInSection section:Int ) -> Int {
        
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
