//
//  WKWebView+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/14.
//

import WebKit

public extension WKWebView {
    static func createWebView() -> WKWebView {
        let wkWebConfig = WKWebViewConfiguration()
        let wkUController = WKUserContentController()
        wkWebConfig.userContentController = wkUController
        
        let jSString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,initial-scale=1.0, maximum-scale=1.0, user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let wkUserScript = WKUserScript(source: jSString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        wkUController.addUserScript(wkUserScript)
        
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1), configuration: wkWebConfig)
        
        return webView
    }
}
