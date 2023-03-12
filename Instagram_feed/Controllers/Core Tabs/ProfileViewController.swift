//
//  ProfileViewController.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/20/23.
//

import UIKit

/// Profile view controller 
///

final class ProfileViewController: UIViewController {

    private  var  collectionView : UICollectionView?
    
    private var  userPosts = [UserPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationBar()
  
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top:0,left:1, bottom: 0, right: 1)
        let boxSize  = (view.width - 4 )/3
        layout.itemSize = CGSize(width: boxSize, height: boxSize)
        
        
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)

        // Cells
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        // Headers
        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)

        
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            
            
            return
        }
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
     private func configureNavigationBar(){
         
         // Create a UIBarButtonItem object with a system button type
         let settingsButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettingsButton))

         // Set the tint color of the UIBarButtonItem
         settingsButtonItem.tintColor = .label

         
         navigationItem.rightBarButtonItem = settingsButtonItem
         
    }
    
    @objc private func didTapSettingsButton(){
        
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}



// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate



extension ProfileViewController: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
  
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
 //  return userPosts.count
     return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        //cell.configure(with: model)
        cell.configure(debugImage: "art")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        //get model and open  post controller
        //let model = userPosts(indexPath.row)
        let vc = PostViewController(model: nil)
        vc.title = "Post"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {

            // not a footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            
            // tab header
        let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as!ProfileTabsCollectionReusableView
            tabControlHeader.delegate = self
            return tabControlHeader
            
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
        
        profileHeader.delegate = self
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
        // Profile info
            return CGSize(width: collectionView.width, height: collectionView.height/4)
        }
        // Size of section tabs
        return  CGSize(width: collectionView.width, height: 56)
    }
}




// MARK: - ProfileInfoHeaderCollectionReusableViewDelegate


extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostsInfoButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        // scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }

    func profileHeaderDidTapFollowersInfoButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@joe", name: "Joe Smith", type: x % 2 == 0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func profileHeaderDidTapFollowingInfoButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        
        var mockData =  [UserRelationship]()
        for x in 0..<10 {
            mockData.append(UserRelationship(username: "@joe", name: "Joe Smith" , type: x % 2 == 0 ? .following : .not_following ))
        }
        
        let vc = ListViewController(data: mockData)

        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
    }
    
    func profileHeaderDidTapShareProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {

        let textToShare = "Join me on Instagram!"
        let appUrl = URL(string: "https://l.instagram.com/?u=https%3A%2F%2Fitunes.apple.com%2Fapp%2Finstagram%2Fid389801252%3Fpt%3D428156%26ct%3Digweb.loginPage.badge%26mt%3D8%26vt%3Dlo&e=AT34_WG2FUCQ85QLgpzqHDJZltwweCF05LsyRLvim1R3qEBHsB9PDPBy1ranxOEmTVCKb5XHQt-APlKbpQJ1rh-lrkOazSX8ErhZhHziE8ipKidtk0V61TpoR0FltoDSeADBWUn1YwyV6LNfHYfQcEqtQoN6FhTheFs9MOXfO74")

        let activityViewController = UIActivityViewController(activityItems: [textToShare, appUrl!], applicationActivities: nil)



        self.present(activityViewController, animated: true, completion: nil)
        
        
    }

}




extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapTaggedButton() {
        //Reload collection view
    }
    
    func didTapGridButton() {
        
    }
    
}
