//
//  NotificationsLikeEventTableViewCell.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/11/23.
//
import SDWebImage
import UIKit



protocol NotificationsLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationsLikeEventTableViewCell: UITableViewCell {
    static let identifier = "NotificationsLikeEventTableViewCell"
    
    
    weak var delegate: NotificationsLikeEventTableViewCellDelegate?
    
    
    private var model:UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "profile-photo-1")
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.text = "@Jenna liked your photo"
        label.textColor = .label
        return label
    }()
    
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = Constants.cornerRadius
        button.setBackgroundImage(UIImage(named: "art"), for: .normal)
        button.backgroundColor = .secondaryLabel
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(profileImageView)
        contentView.addSubview(postButton)
        selectionStyle = .none
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
    }
    
    
    @objc private func didTapPostButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapRelatedPostButton(model: model)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: UserNotification) {
        self.model = model

        switch model.type {
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("https://images.pexels.com/photos/315191/pexels-photo-315191.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2") else {
                return
            }
            postButton.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
        case .follow:
            break
        }

        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        label.text = nil
        postButton.setTitle(nil, for: .normal)
        postButton.layer.borderWidth = 0
        postButton.setBackgroundImage(nil, for: .normal)
        postButton.backgroundColor = nil
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 16,
                                        y: (contentView.height-(contentView.height-16))/2,
                                        width: contentView.height-16,
                                        height: contentView.height-16)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonSize = contentView.height - 4
        
        label.frame = CGRect(x: profileImageView.right + 6,
                             y: 0,
                             width: contentView.width-buttonSize-profileImageView.width-16,
                             height:  contentView.height)
        
        postButton.frame = CGRect(x: contentView.width - 16 - buttonSize,
                                  y:(contentView.height-buttonSize)/2,
                                  width: buttonSize,
                                  height: buttonSize)
    }
}
