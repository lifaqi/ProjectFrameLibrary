//
//  ReachabilityManage.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2023/1/2.
//

import UIKit
import Reachability

public enum ReachabilityConnectionState {
    case wifi
    case cellular
    case unavailable
}

public class ReachabilityManage: NSObject {
    typealias ReachabilityManageCallBack = (_ connectionState: ReachabilityConnectionState) -> ()
    var reachabilityManageCallBack: ReachabilityManageCallBack?
    
    /// 监测网络
    public static var sharedInstance = ReachabilityManage()
    public var connectionState: ReachabilityConnectionState!
    
    private var reachability: Reachability!
    
    override init() {
        super.init()
        
        reachability = try! Reachability()
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                self.connectionState = .wifi
                if self.reachabilityManageCallBack != nil {
                    self.reachabilityManageCallBack!(.wifi)
                }
            }else if reachability.connection == .cellular {
                self.connectionState = .cellular
                self.reachabilityManageCallBack!(.cellular)
            }else{
                self.connectionState = .unavailable
                self.reachabilityManageCallBack!(.unavailable)
            }
        }
        reachability.whenUnreachable = { _ in
            self.connectionState = .unavailable
            self.reachabilityManageCallBack!(.unavailable)
        }
    }
}
