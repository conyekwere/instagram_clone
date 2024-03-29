//
//  Models.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 3/4/23.
//

import Foundation

enum Gender {
   case male ,female,other
}


public struct User {
    let username: String
    let bio: String
    let name: (first:String, last:String)
    let birthDate : Date
    let gender: Gender
    let profilePhoto: URL
    let counts: UserCount
    let JoinDate : Date
    
}

struct UserCount{
    let followers: Int
    let following: Int
    let posts: Int
}


public enum UserPostType:String {
    case photo = "Photo"
    case video = "Video"
}

///  Represents a user post
public struct UserPost {
    let identifier : String
    let postType : UserPostType
    let thumbnailImage: URL
    let PostURL: URL // either video url or full res Photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [User]
    let owner: User
}



struct PostLike{
    let username: String
    let postIdentifier: String
}

struct CommentLike{
    let username: String
    let commentIdentifier: String
}

struct PostComment{
    let identifier : String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}
