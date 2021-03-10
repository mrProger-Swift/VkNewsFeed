//
//  NewsFeedCell.swift
//  WallNewsVK
//
//  Created by User on 08.01.2021.
//
import UIKit
import Foundation
import SDWebImage
protocol FeetCellViewModel{
    
    var iconUrlString: String {get}
    var name : String {get}
    var date: String {get}
    var text: String? {get}
    var likes: String{get}
    var comments: String? {get}
    var shares: String? {get}
    var views: String? {get}
    var photoAttachment : FeedCellPhotoAttachmentViewModel? {get}
    var sizes : FeedCellSizes {get}
}
protocol FeedCellPhotoAttachmentViewModel : TitleViewViewModel{
    var photoUrlString: String? {get}
    var width: Int {get}
    var height: Int {get}
}

protocol FeedCellSizes{
    var postLabelFrame: CGRect {get}
    var attachmentFrame: CGRect {get}
    var buttomView: CGRect {get}
    var totalHeight: CGFloat {get}
    
}

class NewsFeedCell: UITableViewCell{
    static var reusableId = "NewsFeedCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    
    
    func setdata(viewModel: FeetCellViewModel) {
        iconImageView.sd_setImage(with: URL(string: viewModel.iconUrlString), completed: nil)
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postLabel.frame = viewModel.sizes.postLabelFrame
        bottomView.frame = viewModel.sizes.buttomView
        postImageView.frame = viewModel.sizes.attachmentFrame
        
        if let photoAtachment = viewModel.photoAttachment{
            postImageView.sd_setImage(with:URL(string: photoAtachment.photoUrlString!), completed: nil)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        backgroundColor = .clear
        selectionStyle = .none
        if postLabel.text!.count < 3 {
            postLabel.isHidden = true
        }else {
            postLabel.isHidden = false
        }
    }
}

