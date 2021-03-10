//
//  NewsFeedCellLayoutCalculator.swift
//  WallNewsVK
//
//  Created by User on 10.01.2021.
//
//
protocol FeedCellLayoutCalculatorProtocol{
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?)->FeedCellSizes
}

import Foundation
import UIKit
class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)){
        self.screenWidth = screenWidth
    }
    
    struct Constants {
        static let cardInsetrts = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
        static let topViewHeight: CGFloat = 50
        static let postlabelInsets = UIEdgeInsets(top: 8 + Constants.topViewHeight + 8, left: 8, bottom: 8, right: 8)
        static let postLabelFont = UIFont.systemFont(ofSize: 15)
        static let bottomViewHeight: CGFloat = 44
    }
    
    
    struct Sizes : FeedCellSizes{
        var buttomView: CGRect
        var totalHeight: CGFloat
        var postLabelFrame: CGRect
        var attachmentFrame: CGRect
    }
    
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?)->FeedCellSizes{
        let cardViewWidth = screenWidth - Constants.cardInsetrts.left - Constants.cardInsetrts.right
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postlabelInsets.left,
                                                    y: Constants.postlabelInsets.top),
                                    size: .zero)
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postlabelInsets.left - Constants.postlabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postlabelInsets.top : postLabelFrame.maxY + Constants.postlabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        if let attachment = photoAttachment {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        }
        
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                     size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsetrts.bottom
        return Sizes(buttomView: bottomViewFrame,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame)
    }
}


