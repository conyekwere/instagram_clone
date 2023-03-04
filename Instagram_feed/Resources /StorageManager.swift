//
//  StorageManager.swift
//  Instagram_feed
//
//  Created by Chima onyekwere on 2/22/23.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    
    public enum IGStorageManagerError: Error{
        case failedtoDownload
        
        
    }
    //Mark: - Public
    
    public func uploadUserPost(model: UserPost,  completion: @escaping (Result<URL, Error>) -> Void){
        
        
    }
    

    public func downloadImage(with reference: String, completion: @escaping (Result<URL,IGStorageManagerError>)-> Void){
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedtoDownload))
                return
                
            }
            completion(.success(url))
        })
    }
}
public enum UserPostType {
    case photo , video
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
