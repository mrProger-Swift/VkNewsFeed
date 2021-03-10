//
//  NewsfeedInteractor.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    private var fetcher : DataFetcher = NetworkDataaFetcher(networking: NetworkService())
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        switch request{
        case .getNewsFeed:
            fetcher.getFeed { (feedResponce) in
                guard let feedResponce = feedResponce else {return}
                self.presenter?.presentData(response: .presentNewsFeed(feed: feedResponce))
            }
        case .getUser:
            fetcher.getUser { [weak self] (userResponse) in
                self?.presenter?.presentData(response:
                                            Newsfeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
            }
        }
    }
}
