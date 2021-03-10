//
//  String+Height.swift
//  WallNewsVK
//
//  Created by User on 10.01.2021.
//

import Foundation
import UIKit
extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return size.height
    }
    
}
