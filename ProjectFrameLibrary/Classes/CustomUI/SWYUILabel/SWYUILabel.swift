//
//  SWYUILabel.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/14.
//

import UIKit

open class SWYUILabel: UILabel {
    var textContainerInset: UIEdgeInsets = UIEdgeInsets.zero
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textContainerInset))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = textContainerInset
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        
        return rect
    }
}
