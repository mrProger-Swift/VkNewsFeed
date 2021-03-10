//
//  NetworkDataaFetcher.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//

import Foundation
protocol DataFetcher{
    func getFeed(responce: @escaping(FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
    
}

struct NetworkDataaFetcher: DataFetcher {
    
    let networking: Networking
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = AuthService.shared.userId else { return }
        let params = ["user_ids": userId, "fields": "photo_100"]
        networking.request(path: Constants.user, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJson(type: UserResponseWrapped.self, from: data)
            response (decoded?.response.first)
        }
    }
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getFeed(responce: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        networking.request(path: Constants.newsFeed, params: params) { (data,error)  in
            guard let data = data else {responce(nil); return}
            let decoded = self.decodeJson(type: FeedResponceWrapped.self, from: data)
            responce(decoded?.response)
        }
    }
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let responce = try? decoder.decode(type.self, from: data) else {return nil}
        return responce
    }
}
