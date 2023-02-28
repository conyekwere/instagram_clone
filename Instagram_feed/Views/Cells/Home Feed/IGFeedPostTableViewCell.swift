//
//  IGFeedPostTableViewCell.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/26/23.
//

/// cell based on HomeViewController table 
import UIKit

final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public func configure() {
        // configure the cell 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
