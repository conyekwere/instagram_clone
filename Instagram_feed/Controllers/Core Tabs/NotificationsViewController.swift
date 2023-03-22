//
//  NotificationsViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit

enum UserNotificationType{
    case like(post: UserPost)
    case follow(state : FollowState)
}

struct UserNotification {
    let type:UserNotificationType
    let text:String
    let user:User
}


final class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationsLikeEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationsLikeEventTableViewCell.identifier)
        tableView.register(NotificationsFollowEventTableViewCell.self,
                           forCellReuseIdentifier: NotificationsFollowEventTableViewCell.identifier)
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
    
    private var models = [UserNotification]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
        view.addSubview(spinner)
        //spinner.startAnimating()
        view.addSubview(tableView)
        addNoNotificationsView()
        tableView.delegate = self
        tableView.dataSource  = self
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100).integral
        spinner.center = view.center
    }
    
    private func fetchNotifications(){
        for x in 0...10{
            
            let user = User(username: "@Johny7",
                            bio: "i love my job",
                            name: ("John", "Conner"),
                            birthDate: Date(),
                            gender: .male,
                            profilePhoto: URL(string: "https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!,
                            counts: UserCount(followers: 50, following: 50, posts: 69), JoinDate: Date())
            
            let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://images.pexels.com/photos/315191/pexels-photo-315191.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!, PostURL: URL(string: "https//www.google.com")!, caption: "String", likeCount:[], comments: [], createdDate: Date(), taggedUsers:[], owner: user)
            let model = UserNotification(type: x %  2 == 0 ? .like(post: post) : .follow(state: .following), text: "Hello world", user: user)
            
            models.append(model)
        }
    }
    
    private func addNoNotificationsView(){
        
        if models.count < 0  {
            tableView.isHidden = true
            view.addSubview(noNotificationsView)
            noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/3)
            noNotificationsView.center = view.center
        }
        else {return}
        
        
    }
    
    func tableView(_ tableView: UITableView,  numberOfRowsInSection section:Int ) -> Int {
        
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type{
        case .like(_):
            // like cell
            let cell =  tableView.dequeueReusableCell(withIdentifier: NotificationsLikeEventTableViewCell.identifier, for: indexPath) as! NotificationsLikeEventTableViewCell
            
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow :
            
            // follow cell
            let cell =  tableView.dequeueReusableCell(withIdentifier: NotificationsFollowEventTableViewCell.identifier, for: indexPath) as! NotificationsFollowEventTableViewCell
            
            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56.0
    }
}


extension NotificationsViewController: NotificationsLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev Issue: Should never get called")
        }
    }
    
    
}


extension NotificationsViewController: NotificationsFollowEventTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped button")
        
        //Open the post
        
    }
    
    
}
