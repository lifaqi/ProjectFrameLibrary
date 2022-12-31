//
//  UIAlertController+Extension.swift
//  ProjectFrameSwift
//
//  Created by apple on 2022/2/7.
//

import UIKit

extension UIAlertController {
    static func alertView(title: String?, msg: String?, cancelButtonTitle: String?, otherButtonTitle: [String?], style: UIAlertController.Style = .alert, cancelButtonColor: UIColor? = nil, otherButtonColor: UIColor? = nil, handler: ((_ index: Int, _ alertAction: UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: style)
        
        if cancelButtonTitle != nil {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { alertAction in
                handler!(0, alertAction)
            }
            if cancelButtonColor != nil {
                cancelAction.setValue(cancelButtonColor!, forKey: "titleTextColor")
            }
            alertController.addAction(cancelAction)
        }
        
        if otherButtonTitle.count > 0 {
            for i in 0..<otherButtonTitle.count {
                if otherButtonTitle[i] == nil {
                    continue
                }
                
                let otherAction = UIAlertAction(title: otherButtonTitle[i], style: .default) { alertAction in
                    handler!(i + 1, alertAction)
                }
                if otherButtonColor != nil {
                    otherAction.setValue(otherButtonColor!, forKey: "titleTextColor")
                }
                alertController.addAction(otherAction)
            }
        }
        
        UIApplication.getTopViewController()?.present(alertController, animated: true, completion: nil)
    }
    
    static func alertView(title: String?, msg: String?, cancelButtonTitle: String?, otherButtonTitle: String?..., style: UIAlertController.Style = .alert, cancelButtonColor: UIColor? = nil, otherButtonColor: UIColor? = nil, handler: ((_ index: Int, _ alertAction: UIAlertAction) -> Void)?) {
        self.alertView(title: title, msg: msg, cancelButtonTitle: cancelButtonTitle, otherButtonTitle: otherButtonTitle, style: style, cancelButtonColor: cancelButtonColor, otherButtonColor: otherButtonColor, handler: handler)
    }
}

