//
//  DefaultsKeys+Extension.swift
//  ProjectFrameSwift
//
//  Created by apple on 2022/2/7.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    /// 是否是首次打开App，默认true
    public var isFirstOpen: DefaultsKey<Bool> {.init("isFirstOpen", defaultValue: true)}
    /// 是否登陆，默认false
    public var isLogin: DefaultsKey<Bool> {.init("isLogin", defaultValue: false)}
    /// 语言管理，默认是系统设置的语言
    public var appLanguage: DefaultsKey<String> {.init("appLanguage", defaultValue: NSLocale.preferredLanguages.first!)}
}
