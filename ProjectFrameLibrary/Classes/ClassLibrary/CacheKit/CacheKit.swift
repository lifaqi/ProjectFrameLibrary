//
//  CacheKit.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2023/1/3.
//

import Foundation

/// 显示缓存大小
public func getCacheSize() -> CGFloat {
    let cachPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first
    
    return CGFloat(folderSizeAtPath(folderPath: cachPath!) / 1024 / 1024)
}

/// 计算单个文件的大小
func fileSizeAtPath(filePath: String) -> UInt64 {
    let manager = FileManager.default
    if manager.fileExists(atPath: filePath) {
        do {
            let attr = try manager.attributesOfItem(atPath: filePath)
            return attr[FileAttributeKey.size] as! UInt64
        }catch {
            print("fileSizeAtPath error")
        }
    }
    
    return 0
}

/// 遍历文件夹获得文件夹大小，返回多少M
func folderSizeAtPath(folderPath: String) -> UInt64 {
    let manager = FileManager.default
    if manager.fileExists(atPath: folderPath) {
        let childFilePath = manager.subpaths(atPath: folderPath)!
        var folderSize: UInt64 = 0
        for path in childFilePath {
            let filePath = folderPath+"/"+path
            folderSize += fileSizeAtPath(filePath: filePath)
        }
    }
    
    return 0
}

/// 清理缓存
public func clearCache() {
    let cachPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    let manager = FileManager.default
    let childFilePath = manager.subpaths(atPath: cachPath)!
    for file in childFilePath {
        let filePath = cachPath+"/"+file
        if manager.fileExists(atPath: filePath) {
            do {
                try manager.removeItem(atPath: filePath)
            }catch {
                print("clearCache error")
            }
        }
    }
    
    ToolKit.showSuccess(msg: "清理成功")
}
