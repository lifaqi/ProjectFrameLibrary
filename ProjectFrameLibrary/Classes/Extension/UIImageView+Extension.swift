//
//  UIImageView+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/29.
//

import UIKit

public extension UIImageView {
    static func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
}
