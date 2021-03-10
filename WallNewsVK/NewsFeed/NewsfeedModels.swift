//
//  NewsfeedModels.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct UserViewModel: TitleViewViewModel {
    var photoUrlString: String?
}

enum Newsfeed {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getNewsFeed
                case getUser
            }
        }
        struct Response {
            enum ResponseType {
                case presentNewsFeed(feed: FeedResponse)
                case presentUserInfo(user: UserResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayNewsFeed(feedViewModel: FeetViewModel)
                case displayUser(userViewModel: UserViewModel)
            }
        }
    }
}

struct FeetViewModel {
    struct Cell: FeetCellViewModel {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var sizes: FeedCellSizes
    }
    
    struct  FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    let cells: [Cell]
}
