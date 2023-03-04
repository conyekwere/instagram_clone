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
    
    /// this is set as on optional so that we can set as self
    

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
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
    
}

//extension ProfileViewController: ProfileInfoHeaderCollectionReusableViewDelegate {
//    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView) {
//        // scroll to the posts
//        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
//    }
//
//    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
//        var mockData = [UserRelationship]()
//        for x in 0..<10 {
//            mockData.append(UserRelationship(username: "@joe", namm: "Joe Smith", type: x % 2 == 0 ? .following : .not_following))
//        }
//        let vc = ListViewController(data: mockData)
//        vc.title = "Followers"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
//        var mockData = [UserRelationship]()
//        for x in 0..<10 {
//            mockData.append(UserRelationship(username: "@joe", namm: "Joe Smith", type: x % 2 == 0 ? .following : .not_following))
//        }
//        let vc = ListViewController(data: mockData)
//        vc.title = "Following"
//        vc.navigationItem.largeTitleDisplayMode = .never
//        navigationController?.pushViewController(vc, animated: true)
//    }
//
//    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView) {
//        let vc = EditProfileViewController()
//        vc.title = "Edit Profile"
//        present(UINavigationController(rootViewController: vc), animated: true)
//    }
//
//}
//
//extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
//    func didTapGridButtonTab() {
//        // Reload collection view with data
//    }
//
//    func didTapTaggedButtonTab() {
//        // Reload collection view with data
//    }
//}
