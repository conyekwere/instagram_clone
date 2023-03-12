//
//  NotificationsFollowEventTableViewCell.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/11/23.
//

import UIKit

class NotificationsFollowEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationsFollowEventTableViewCell"
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
//        label.text = "@joe"
        label.textColor = .label
        return label
    }()
    
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
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
    
    
    @objc private func didTapFollowButton(){

     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(with model: UserRelationship) {
//        self.model = model
//        nameLabel.text = model.name
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
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.height-8,
                                        height: contentView.height-8)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        
        let labelHeight = contentView.height/3
        label.frame = CGRect(x: profileImageView.right+5,
                                 y: 0,
                                 width: contentView.width-8-profileImageView.width,
                                 height: labelHeight)

    }

}
