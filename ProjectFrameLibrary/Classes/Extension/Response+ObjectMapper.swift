//
//  File.swift
//  BeautifulGirl
//
//  Created by jianwen ning on 31/08/2019.
//  Copyright © 2019 jianwen ning. All rights reserved.
//

import Moya
import ObjectMapper


// MARK: - Json -> Model
extension Response {
    // 将Json解析为单个Model
    public func mapBaseModel<T: BaseMappable>(_ type: T.Type) throws -> T {
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        let model = Mapper<T>().map(JSON: json)!
        
        return model
    }
    
    // 将Json解析为单个Model
    public func mapModel<T: BaseMappable>(_ type: T.Type) throws -> T {
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let jsonDict = (json["result"] as? [String : Any]) else {
            throw MoyaError.jsonMapping(self)
        }
        
        let model = Mapper<T>().map(JSON: jsonDict)!
        
        return model
    }
    
    // 将Json解析为多个Model，返回数组，对于不同的json格式需要对该方法进行修改
    public func mapArray<T:BaseMappable>(_ type: T.Type) throws -> [T] {
        
        guard let json = try mapJSON() as? [String : Any] else {
            throw MoyaError.jsonMapping(self)
        }
        
        guard let jsonArr = (json["result"] as? [[String : Any]]) else {
            throw MoyaError.jsonMapping(self)
        }
        
        return Mapper<T>().mapArray(JSONArray: jsonArr)
    }
}

enum RxSwiftMoyaError : Swift.Error {
    case ParseJSONError
    case NoRepresentor
    case NotSuccessfulHTTP
    case NoData
    case CouldNotMakeObjectError
    case BizError(resultCode: String, resultMsg: String)
}

extension RxSwiftMoyaError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .ParseJSONError:
            return "数据解析失败"
        case .NoRepresentor:
            return "NoRepresentor."
        case .NotSuccessfulHTTP:
            return "NotSuccessfulHTTP."
        case .NoData:
            return "NoData."
        case .CouldNotMakeObjectError:
            return "CouldNotMakeObjectError."
        case .BizError(resultCode: let resultCode, resultMsg: let resultMsg):
            return "错误码: \(resultCode), 错误信息: \(resultMsg)"
        }
    }
}
