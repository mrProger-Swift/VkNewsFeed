//
//  FeedResponce.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//
//
import Foundation

struct FeedResponceWrapped: Decodable {
    let response : FeedResponse
}

struct FeedResponse: Decodable {
    var items : [FeedItem]
    var profiles: [Profile]
    var groups: [Group]
}

protocol ProfileRepresenatable {
    var id: Int {get}
    var name: String {get}
    var photo: String {get}
}

struct Profile: Decodable, ProfileRepresenatable{
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String{
        return firstName + " " + lastName
    }
    var photo: String{
        return photo100
    }
}

struct Group: Decodable, ProfileRepresenatable{
    let id: Int
    let name: String
    let photo100: String
    var photo: String{
        return photo100
    }
}

struct FeedItem: Decodable{
    let sourceId: Int
    let postId : Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
    let attachments: [Attachments]?
}

struct Attachments: Decodable{
    let photo: Photo?
}

struct Photo: Decodable{
    let sizes: [PhotoSize]
    private func getproperSize() -> PhotoSize{
        if let sizeX = sizes.first(where: { $0.type == "x"}){
            return sizeX
        } else if let fall = sizes.last{
            return fall
        }
        return PhotoSize(type: "wrong", width: 0, height: 0, url: "WrongUrl")
    }
    var height: Int{
        return getproperSize().height
    }
    var width: Int{
        return getproperSize().width
    }
    var srcBig: String{
        return getproperSize().url
    }
}

struct PhotoSize: Decodable{
    let type: String
    let width : Int
    let height: Int
    let url: String
}

struct CountableItem: Decodable{
    let count : Int
}

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
