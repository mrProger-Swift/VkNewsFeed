//
//  NewsfeedPresenter.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    weak var viewController: NewsfeedDisplayLogic?
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ru_Ru")
        df.dateFormat = "d MMM 'B' HH:mm"
        return df
    }()
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        switch response{
        case .presentNewsFeed(feed: let feed):
            let cells = feed.items.map { (feedItem) in
                cellViewModel(from: feedItem, profile: feed.profiles, groups: feed.groups)
            }
            let feetViewModel = FeetViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feetViewModel))
        case .presentUserInfo(user: let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel:
                                    Newsfeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
        }
    }
    private func cellViewModel(from feeditem : FeedItem, profile: [Profile], groups: [Group])-> FeetViewModel.Cell{
        let profiles = self.profile(for: feeditem.sourceId, profiles: profile, groups: groups)
        let date = Date(timeIntervalSince1970: feeditem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAtachment = photoAttachment(feedItem: feeditem)
        let sizes = cellLayoutCalculator.sizes(postText: feeditem.text, photoAttachment: photoAtachment )
        return FeetViewModel.Cell.init(iconUrlString: profiles.photo,
                                       name: profiles.name,
                                       date: dateTitle,
                                       text: feeditem.text,
                                       likes: String(feeditem.likes?.count ?? 0),
                                       comments:  String(feeditem.comments?.count ?? 0),
                                       shares: String(feeditem.reposts?.count ?? 0),
                                       views: String(feeditem.views?.count ?? 0),
                                       photoAttachment: photoAtachment, sizes: sizes)
    }
    
    private func profile(for sourceId: Int, profiles: [Profile], groups: [Group])-> ProfileRepresenatable{
        let profilesOrGroups: [ProfileRepresenatable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { (myprofileRepresentable) -> Bool in
            myprofileRepresentable.id == normalSourceId
        }
        return profileRepresentable!
    }
    
    private func photoAttachment(feedItem: FeedItem)-> FeetViewModel.FeedCellPhotoAttachment?{
        guard let photos = feedItem.attachments?.compactMap({ (attachment)  in
            attachment.photo
        }), let first = photos.first else {return nil}
        return FeetViewModel.FeedCellPhotoAttachment.init(photoUrlString:
                                                            first.srcBig, width: first.width, height: first.height)
    }
}
