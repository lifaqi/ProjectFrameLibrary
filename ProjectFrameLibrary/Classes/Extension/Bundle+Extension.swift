//
//  Bundle+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/6/20.
//

import Foundation

enum Language : String {
    case english = "en"
    case chinese = "zh-Hans"
}

open class BundleEx: Bundle {
    open override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = Bundle.getLanguageBundel() {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }else{
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}

extension Bundle {
    private static var onLanguageDispatchOnce: ()->Void = {
        //替换Bundle.main为自定义的BundleEx
        object_setClass(Bundle.main, BundleEx.self)
    }
    
    /// 初始化
    func onLanguage(){
        Bundle.onLanguageDispatchOnce()
    }
    
    static func getLanguageBundel() -> Bundle? {
        let languageBundlePath = Bundle.main.path(forResource: Defaults.appLanguage, ofType: "lproj")
        guard languageBundlePath != nil else {
            return nil
        }
        
        let languageBundle = Bundle.init(path: languageBundlePath!)
        
        return languageBundle
    }
}
