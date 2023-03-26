//
//  ViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit
import FirebaseAuth


struct HomeFeedRenderViewModel{
    
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createMockModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    private func createMockModels(){
        
        
        let user = User(username: "@Johny7",
                        bio: "i love my job",
                        name: ("John", "Conner"),
                        birthDate: Date(),
                        gender: .male,
                        profilePhoto: URL(string: "https://images.pexels.com/photos/2726111/pexels-photo-2726111.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!,
                        counts: UserCount(followers: 50, following: 50, posts: 69), JoinDate: Date())
        
        let post = UserPost(identifier: "", postType: .photo, thumbnailImage: URL(string: "https://images.pexels.com/photos/315191/pexels-photo-315191.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")!, PostURL: URL(string: "https//www.google.com")!, caption: "String", likeCount:[], comments: [], createdDate: Date(), taggedUsers:[], owner: user)

        
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(
                PostComment(
                    identifier: "123_\(x)",
                    username: "@dave",
                    text: "Great post!",
                    createdDate: Date(),
                    likes: []
                )
            )
        }
        
        for x in 0..<5{
            
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: post.owner)),
                                                    post:  PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "actions")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // check auth status
        handleNotAuthenticated()
        
        
    }
    
    private func handleNotAuthenticated(){
        if Auth.auth().currentUser == nil{
            //Show log in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC,animated: false)
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            // section zero will crash our app because it will return zero with should not happen
            model = feedRenderModels[0]
        }
        
        else{
            
            // for each batch of the same section we want to user the same model
            
            
            let modelPlacement = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            
            // 4 % 4 == 0 ? 4/4 :  if 4 is divisible output the value equals 1
            // else ((x - (x % 4)) / 4)
            
            // section 1 :  ((1 - (1 % 4)) / 4) = 0
            // section 2 :  ((2 - (2 % 4)) / 4) = 0
            // section 3 :  ((3 - (3 % 4)) / 4) = 0
            // section 4 :  ((4 - (4 % 4)) / 4) = 0
            
            // after this map secions to array
            model = feedRenderModels[modelPlacement]
        }
        let subSection = x % 4
        
        if subSection == 0 {
            // header  feedRenderModels[modelPlacement].header
            return 1
        }
        else if subSection == 1 {
            //  feedRenderModels[modelPlacement].primaryContent aka post
            return 1
        }
        else if subSection == 2 {
            //  feedRenderModels[modelPlacement].actions
            return 1
        }
        else if subSection == 3 {
            //  feedRenderModels[modelPlacement].comments
            let commentModel = model.comments
            
            switch commentModel.renderType {
            case .comments(let comments):  return  comments.count > 2 ? 2 : comments.count
            case .header,.actions,.primaryContent:  return 0
                
                // show only two comments if comment count has more than two
            }
            
        }
        
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            
            model = feedRenderModels[0]
        }
        
        else{
            let modelPlacement = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            
            model = feedRenderModels[modelPlacement]
        }
        let subSection = x % 4
        
        if subSection == 0 {
            let headerModel = model.header
            
            switch headerModel.renderType {
            case .header(_):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            case .comments,.actions,.primaryContent:  return UITableViewCell()
            }
            
            
        }
        else if subSection == 1 {
            let postModel = model.post
            
            
            switch postModel.renderType {
            case .primaryContent(let post):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .comments,.actions,.header:  return UITableViewCell()
                
            }
            
            
        }
        else if subSection == 2 {
            let actionModel = model.actions
            
            
            switch actionModel.renderType {
            case .actions(let actions):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
                
                
            case .comments,.header,.primaryContent:  return UITableViewCell()
                
                
            }
        }
        else if subSection == 3 {
            let commentModel = model.comments
            
            switch commentModel.renderType {
            case .comments(let comments):
                
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier,
                                                         for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .actions,.header,.primaryContent:  return UITableViewCell()
            }
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let subSection = indexPath.section % 4
        
        if indexPath.row == 0 {
            
        }
        if subSection == 0 {
            
            return 70
            
        }
        
        else if subSection == 1 {
            
            return tableView.width
            
        }
        
        else if subSection == 2 {
            
            return 60
            
        }
        
        else if subSection == 3 {
            
            return 50
            
        }
        
        return 0
    }
    //blank footer for spacing
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {

        let subSection = section % 4
        // return subSection == 3 ? 70 : 0
        if subSection == 3  {
            return 70
            
        }
        
        return 0
    }
}
