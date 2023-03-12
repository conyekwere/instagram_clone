//
//  UserFollowTableViewCell.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/9/23.
//
import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}
enum FollowState{
    case following , not_following
}

struct UserRelationship{
    
    let username: String
    let name: String
    let type: FollowState
}
class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"

    weak var delegate: UserFollowTableViewCellDelegate?

    private var model: UserRelationship?
    


    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .semibold)
//        label.text = "Joe"
        return label
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 14, weight: .regular)
//        label.text = "@joe"
        label.textColor = .secondaryLabel
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
        contentView.addSubview(nameLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowButton(){

        guard let model  = model else { return  }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        usernameLabel.text = model.username
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1.0
            followButton.layer.borderColor = UIColor.label.cgColor
        case .not_following:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        usernameLabel.text = nil
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

        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width/3
        followButton.frame = CGRect(x: contentView.width-5-buttonWidth,
                                    y: (contentView.height-40)/2,
                                    width: buttonWidth,
                                    height: 32)
        
        let labelHeight = contentView.height/3
        nameLabel.frame = CGRect(x: profileImageView.right+5,
                                 y: 0,
                                 width: contentView.width-8-profileImageView.width-buttonWidth,
                                 height: labelHeight)
        usernameLabel.frame = CGRect(x: profileImageView.right+5,
                                     y: nameLabel.bottom,
                                     width: contentView.width-8-profileImageView.width-buttonWidth,
                                     height: labelHeight)
        
        
        // change view if first item ontable 
//        if let tableView = self.superview as? UITableView,
//            let indexPath = tableView.indexPath(for: self),
//            indexPath.row == 0 {
//             // This is the first cell in the table view
//             // Modify the position of the usernameLabel's frame
////             usernameLabel.frame.origin.y = 10
//            usernameLabel.textColor = .blue
//            // set to desired y coordinate
//         }
        
    }
    
}
