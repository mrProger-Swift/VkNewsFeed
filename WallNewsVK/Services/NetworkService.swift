//
//  NetworkService.swift
//  WallNewsVK
//
//  Created by User on 07.01.2021.
//


protocol Networking{
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

import Foundation
class NetworkService: Networking{
    
    private func url(from path: String, params: [String: String]) -> URL{
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.host
        components.path = path
        components.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
        let url = components.url!
        return url
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = AuthService.shared.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = Constants.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
