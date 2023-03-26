//
//  IGFeedPostTableViewCell.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/26/23.
//

/// cell based on HomeViewController table

import SDWebImage
import UIKit


/// Cell
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        return imageView
        
    }()


    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        contentView.addSubview(postImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image "
        accessibilityHint = "Double-tap to like post "
        
    }
    
    
    public func configure(with post: UserPost){
        switch post.postType {
        case .photo:
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("https://images.pexels.com/photos/315191/pexels-photo-315191.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2") else {
                return
            }
            postImageView.sd_setBackgroundImage(with: thumbnail,
                                             for: .normal,
                                             completed: nil)
        case .video:
            break
        }
        
        
        let url = post.thumbnailImage
        
        postImageView.sd_setImage(with: url, completed: nil)

    }

    public func configure(debugImage imageName: String){
        postImageView.image = UIImage(named: imageName)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
    }
}

