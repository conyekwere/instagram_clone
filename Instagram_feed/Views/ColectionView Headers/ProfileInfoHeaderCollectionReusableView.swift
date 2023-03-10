//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/4/23.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsInfoButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersInfoButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingInfoButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapShareProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate : ProfileInfoHeaderCollectionReusableViewDelegate?
    
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profile-photo")
        return imageView
    }()
    
    private let postInfoButton: UIButton = {
        let button = UIButton()

        button.setTitle("Posts ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followingInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following  ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let followersInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers ", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Edit Profile ", for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let shareProfileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.setTitle("Share Profile ", for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = Constants.cornerRadius
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14)
        label.text =  "Chima"
        label.numberOfLines = 1
        return label
    }()
    
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text =  "🇳🇬 Product Designer | iOS Developer | Illustrator"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    
    //Mark - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .systemFill
        clipsToBounds = true
        addSubviews()
        addButtonActions()
        
    }
    
    
    private func addSubviews(){
        addSubview(profilePhotoImageView)
        addSubview(postInfoButton)
        addSubview(followingInfoButton)
        addSubview(followersInfoButton)
        addSubview(editProfileButton)
        addSubview(shareProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
        
    }
    
    private func addButtonActions(){
        postInfoButton.addTarget(self, action: #selector(didTapPostInfoButton), for: .touchUpInside)
        
        followingInfoButton.addTarget(self, action: #selector(didTapFollowingInfoButton), for: .touchUpInside)
        
        followersInfoButton.addTarget(self, action: #selector(didTapFollowersInfoButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
        shareProfileButton.addTarget(self, action: #selector(didTapShareProfileButton), for: .touchUpInside)
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        let profilePhotoSize = width/4
        
        profilePhotoImageView.frame  = CGRect(
            x:15,
            y: 20,
            width: width/5,
            height:width/5
        ).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.5
        
        let profileInfoButtonHeight = profilePhotoSize/2
        let profileInfoButtonWidth = (width-10-profilePhotoSize)/3
        
        
        postInfoButton.frame  = CGRect(
            x:profilePhotoImageView.right,
            y: 20,
            width: profileInfoButtonWidth,
            height: profileInfoButtonHeight
        ).integral
        
        followersInfoButton.frame  = CGRect(
            x:postInfoButton.right,
            y: 20,
            width: profileInfoButtonWidth,
            height: profileInfoButtonHeight
        ).integral
        
        
        followingInfoButton.frame  = CGRect(
            x:followersInfoButton.right,
            y: 20,
            width: profileInfoButtonWidth,
            height: profileInfoButtonHeight
        ).integral
        
        
        nameLabel.frame  = CGRect(
            x:15,
            y: profilePhotoImageView.bottom,
            width: width - 10 ,
            height: 30
        )
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame  = CGRect(
            x:15,
            y: nameLabel.bottom,
            width: width - 10 ,
            height: bioLabelSize.height
        ).integral
        
        
        editProfileButton.frame  = CGRect(
            x:profilePhotoImageView.left,
            y: bioLabel.bottom + 10,
            width: (width/2) - 20 ,
            height: profileInfoButtonHeight - 20
        ).integral
        
        shareProfileButton.frame  = CGRect(
            x:editProfileButton.right + 6 ,
            y:bioLabel.bottom + 10,
            width: (width/2) - 20 ,
            height: profileInfoButtonHeight - 20
        ).integral
        

    }
    
    @objc private func didTapPostInfoButton(){

        delegate?.profileHeaderDidTapPostsInfoButton(self)
    }
    @objc private func didTapFollowingInfoButton(){

        delegate?.profileHeaderDidTapFollowingInfoButton(self)
    }
    
    @objc private func didTapFollowersInfoButton(){
        delegate?.profileHeaderDidTapFollowersInfoButton(self)
        
    }
    
    @objc private func didTapEditProfileButton(){

        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
    
    @objc private func didTapShareProfileButton(){

        delegate?.profileHeaderDidTapShareProfileButton(self)
    }
  
}
