//
//  DefaultsKeys+Extension.swift
//  ProjectFrameSwift
//
//  Created by apple on 2022/2/7.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    var isFirstLogin: DefaultsKey<Bool> {.init("isFirstLogin", defaultValue: true)}
    var isLogin: DefaultsKey<Bool> {.init("isLogin", defaultValue: false)}
    
    var appLanguage: DefaultsKey<String> {.init("appLanguage", defaultValue: NSLocale.preferredLanguages.first!)}
}
