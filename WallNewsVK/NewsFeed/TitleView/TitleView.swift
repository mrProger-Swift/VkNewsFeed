//
//  TitleView.swift
//  WallNewsVK
//
//  Created by User on 12.01.2021.
//
protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}


import Foundation
import UIKit
import SDWebImage
class TitleView: UIView{
    
    var photos = [FeedCellPhotoAttachmentViewModel]()
    private var myTextField = insertableTF()
    var myavatarView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        imageview.clipsToBounds = true
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTextField)
        addSubview(myavatarView)
        makeconstrates()
    }
    
    func setAvatar(viewModel : TitleViewViewModel) {
        guard let imageURL = URL(string: viewModel.photoUrlString!) else {return}
        myavatarView.sd_setImage(with: imageURL, completed:  nil)
    }
    
    private func makeconstrates() {
        myavatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4, left: 777, bottom: 777, right: 4))
        myavatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myavatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myTextField.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: myavatarView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    }
    
    override var intrinsicContentSize: CGSize{
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myavatarView.layer.masksToBounds = true
        myavatarView.layer.cornerRadius = myavatarView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
