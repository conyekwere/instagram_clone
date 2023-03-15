//
//  NotificationsFollowEventTableViewCell.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/11/23.
//

import UIKit

protocol NotificationsFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserNotification)
}


class NotificationsFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationsFollowEventTableViewCell"
    
    
    weak var delegate: NotificationsFollowEventTableViewCellDelegate?
    
    private var model:UserNotification?
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.image = UIImage(named: "profile-photo-2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "@Johnbaraxx started following you"
        label.textColor = .label
        return label
    }()
    
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .link
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapFollowButton() {
           guard let model = model else {
               return
           }

           delegate?.didTapFollowUnFollowButton(model: model)
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        
        switch model.type{
            
        case .like(_):
            break
        case .follow(let state):
            // configure button
            
//            guard !model.text.contains("Hello world") else {
//                return
//            }
            
            switch state {
            case .following:
                // show unfollow button
                followButton.setTitle("Following", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.backgroundColor = .systemBackground
                followButton.layer.borderWidth = 1.0
                followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
            case .not_following:
                // show follow button
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.backgroundColor = .link
                followButton.layer.borderWidth = 0
            }
            
        }
        
        
        // define text shown
        label.text = model.text
        // define profile photo
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        //        usernameLabel.text = model.username
        
        
    }
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        label.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 16,
                                        y: (contentView.height-(contentView.height-16))/2,
                                        width: contentView.height-16,
                                        height: contentView.height-16)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3.5
        
        
        label.frame = CGRect(x: profileImageView.right + 6,
                             y: 0,
                             width: contentView.width-buttonWidth-profileImageView.width-60,
                             height:  contentView.height)
        
        followButton.frame = CGRect(x: contentView.width-buttonWidth-16,
                                    y:  (contentView.height-32)/2,
                                    width: buttonWidth,
                                    height: 32)
    }
    
}
