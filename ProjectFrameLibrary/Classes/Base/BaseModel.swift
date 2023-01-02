//
//  BaseModel.swift
//  ProjectFrameSwift
//
//  Created by apple on 2022/1/21.
//

import Foundation
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
