//
//  BaseModel.swift
//  ProjectFrameSwift
//
//  Created by apple on 2022/1/21.
//

import UIKit

class BaseModel: BaseSuperModel{
    static var codeKey = "code"
    static var messageKey = "message"
    
    var code: Int64?
    var message: String?
    
    override func mapping(map: Map) {
        code <- map[BaseModel.codeKey]
        message <- map[BaseModel.messageKey]
    }
}

extension BaseModel {
    var isSuccess: Bool {
        get {
            if code == 200 {
                
                return true
            }else if (code == 403) { // 登陆失效
                UIApplication.getTopViewController()?.navigationController?.pushViewController(LoginViewController(), animated: true)
                
                return false
            }else{
                ToolKit.showError(msg: message ?? "未知错误")
                
                return false
            }
        }
    }
}
