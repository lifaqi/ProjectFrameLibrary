//
//  UIButton+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

private var startTime: Date?
private var endTime: Date?

public typealias BtnAction = (UIButton)->()

public enum ButtonImageStyle {
    case top /// image在上，label在下
    case left /// image在左，label在右
    case bottom /// image在下，label在上
    case right /// image在右，label在左
}

public extension UIButton {
    /// “重新获取”文字自定义
    var reSendTitle: String {
        get {
            if let title = objc_getAssociatedObject(self, &AssociatedKeys.countDownReSendTitleKey) as? String {
                return title
            }else {
                return ""
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.countDownReSendTitleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 秒数前缀文字描述
    var countDownTitlePre: String {
        get {
            if let titlePre = objc_getAssociatedObject(self, &AssociatedKeys.countDownTitlePreKey) as? String {
                return titlePre
            }else {
                return ""
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.countDownTitlePreKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// 秒数后缀文字描述
    var countDownTitleSuf: String {
        get {
            if let titleSuf = objc_getAssociatedObject(self, &AssociatedKeys.countDownTitleSufKey) as? String {
                return titleSuf
            }else {
                return ""
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.countDownTitleSufKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static func createButton(size: CGFloat = 16, textColor: UIColor = BlackColor, style: UIFont.Weight = .regular) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: size, weight: style)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        button.expandSize(size: 10)
        button.isClickDelay = false
        
        return button
    }
    
    /// 按钮扩大点击区域
    func expandSize(size:CGFloat) {
        objc_setAssociatedObject(self, &AssociatedKeys.expandSizeKey,size, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    private func expandRect() -> CGRect {
        let expandSize = objc_getAssociatedObject(self, &AssociatedKeys.expandSizeKey)
        if (expandSize != nil) {
            return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height + 2 * (expandSize as! CGFloat))
        }else{
            return bounds
        }
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let buttonRect =  expandRect()
        if (buttonRect.equalTo(bounds)) {
            return super.point(inside: point, with: event)
        }else{
            return buttonRect.contains(point)
        }
    }
    
    /// 设置图片位置
    func imageLocation(imagePlacement:ButtonImageStyle=ButtonImageStyle.left,imagePadding:CGFloat = 5.ad) {
//        if #available(iOS 15.0, *) {
//            var config = UIButton.Configuration.plain()
//            config.imagePadding = imagePadding
//            switch imagePlacement {
//            case .top:
//                config.imagePlacement = .top
//            case .left:
//                config.imagePlacement = .leading
//            case .bottom:
//                config.imagePlacement = .bottom
//            case .right:
//                config.imagePlacement = .trailing
//            }
//            self.configuration = config
//        } else {
//            // Fallback on earlier versions
//            self.layoutButtonImage(imagePlacement: imagePlacement, imagePadding: imagePadding)
//        }
        
        // Fallback on earlier versions
        self.layoutButtonImage(imagePlacement: imagePlacement, imagePadding: imagePadding)
    }
    
    func layoutButtonImage(imagePlacement:ButtonImageStyle=ButtonImageStyle.left, imagePadding:CGFloat = 5.ad){
        let imageWith = self.imageView?.bounds.width ?? 0
        let imageHeight = self.imageView?.bounds.height ?? 0
        
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        var contentEdgeInsets = UIEdgeInsets.zero
        
        let bWidth = self.bounds.width
        
        let min_height = min(imageHeight, labelHeight)
        
        switch imagePlacement {
        case .left:
            self.contentVerticalAlignment = .center
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: 0,
                                           right: 0)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: imagePadding,
                                           bottom: 0,
                                           right: -imagePadding)
            contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: imagePadding)
        case .right:
            self.contentVerticalAlignment = .center
            var w_di = labelWidth + imagePadding/2
            if (labelWidth+imageWith+imagePadding) > bWidth{
                let labelWidth_f = self.titleLabel?.frame.width ?? 0
                w_di = labelWidth_f + imagePadding/2
            }
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: w_di,
                                           bottom: 0,
                                           right: -w_di)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -(imageWith+imagePadding/2),
                                           bottom: 0,
                                           right: imageWith+imagePadding/2)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: imagePadding/2, bottom: 0, right: imagePadding/2.0)
        case .top:
            //img在上或者在下 一版按钮是水平垂直居中的
            self.contentHorizontalAlignment = .center
            self.contentVerticalAlignment = .center
            
            var w_di = labelWidth/2.0
            //如果内容宽度大于button宽度 改变计算方式
            if (labelWidth+imageWith+imagePadding) > bWidth{
                w_di = (bWidth - imageWith)/2
            }
            //考虑图片+显示文字宽度大于按钮总宽度的情况
            let labelWidth_f = self.titleLabel?.frame.width ?? 0
            if (imageWith+labelWidth_f+imagePadding)>bWidth{
                w_di = (bWidth - imageWith)/2
            }
            imageEdgeInsets = UIEdgeInsets(top: -(labelHeight+imagePadding),
                                           left: w_di,
                                           bottom: 0,
                                           right: -w_di)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageWith,
                                           bottom:-(imagePadding+imageHeight),
                                           right: 0)
            let h_di = (min_height+imagePadding)/2.0
            contentEdgeInsets = UIEdgeInsets(top:h_di,left: 0,bottom:h_di,right: 0)
        case .bottom:
            //img在上或者在下 一版按钮是水平垂直居中的
            self.contentHorizontalAlignment = .center
            self.contentVerticalAlignment = .center
            var w_di = labelWidth/2
            //如果内容宽度大于button宽度 改变计算方式
            if (labelWidth+imageWith+imagePadding) > bWidth{
                w_di = (bWidth - imageWith)/2
            }
            //考虑图片+显示文字宽度大于按钮总宽度的情况
            let labelWidth_f = self.titleLabel?.frame.width ?? 0
            if (imageWith+labelWidth_f+imagePadding)>bWidth{
                w_di = (bWidth - imageWith)/2
            }
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: w_di,
                                           bottom: -(labelHeight+imagePadding),
                                           right: -w_di)
            labelEdgeInsets = UIEdgeInsets(top: -(imagePadding+imageHeight),
                                           left: -imageWith,
                                           bottom: 0,
                                           right: 0)
            let h_di = (min_height+imagePadding)/2.0
            contentEdgeInsets = UIEdgeInsets(top:h_di, left: 0,bottom:h_di,right: 0)
        }
        self.contentEdgeInsets = contentEdgeInsets
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    /// 是否添加开启点击事件延迟1s
    var isClickDelay: Bool {
        get {
            if let clickDelay = objc_getAssociatedObject(self, &AssociatedKeys.countDownIsClickDelayKey) as? Bool {
                return clickDelay
            }else {
                return false
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.countDownIsClickDelayKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc dynamic var actionDic: NSMutableDictionary? {
        set{
            objc_setAssociatedObject(self,&AssociatedKeys.actionKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get{
            if let dic = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) as? NSDictionary{
                return NSMutableDictionary.init(dictionary: dic)
            }
            return nil
        }
    }
    @objc dynamic fileprivate func DIY_button_add(action:@escaping  BtnAction ,for controlEvents: UIControl.Event) {
        let eventStr = NSString.init(string: String.init(describing: controlEvents.rawValue))
        if let actions = self.actionDic {
            actions.setObject(action, forKey: eventStr)
            self.actionDic = actions
        }else{
            self.actionDic = NSMutableDictionary.init(object: action, forKey: eventStr)
        }
        
        switch controlEvents {
        case .touchUpInside:
            self.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
        case .touchUpOutside:
            self.addTarget(self, action: #selector(touchUpOutsideBtnAction), for: .touchUpOutside)
        default:
            break
        }
    }
    @objc fileprivate func touchUpInSideBtnAction(btn: UIButton) {
        if isClickDelay {
            if startTime == nil {
                startTime = Date()
                
                if let actionDic = self.actionDic  {
                    if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? BtnAction{
                        touchUpInSideAction(self)
                    }
                }
            }else{
                let result = startTime?.timeDifference(toDate: Date(), components: [.second])
                if(result?.second ?? 0 >= 1) {
                    startTime = Date()
                    
                    if let actionDic = self.actionDic  {
                        if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? BtnAction{
                            touchUpInSideAction(self)
                        }
                    }
                }
            }
        }else{
            if let actionDic = self.actionDic  {
                if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? BtnAction{
                    touchUpInSideAction(self)
                }
            }
        }
    }
    @objc fileprivate func touchUpOutsideBtnAction(btn: UIButton) {
        if isClickDelay {
            if startTime == nil {
                startTime = Date()
                
                if let actionDic = self.actionDic  {
                    if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? BtnAction{
                        touchUpInSideAction(self)
                    }
                }
            }else{
                let result = startTime?.timeDifference(toDate: Date(), components: [.second])
                if(result?.second ?? 0 >= 1) {
                    startTime = Date()
                    
                    if let actionDic = self.actionDic  {
                        if let touchUpOutsideBtnAction = actionDic.object(forKey:   String.init(describing: UIControl.Event.touchUpOutside.rawValue)) as? BtnAction{
                            touchUpOutsideBtnAction(self)
                        }
                    }
                }
            }
        }else{
            if let actionDic = self.actionDic  {
                if let touchUpInSideAction = actionDic.object(forKey: String.init(describing: UIControl.Event.touchUpInside.rawValue)) as? BtnAction{
                    touchUpInSideAction(self)
                }
            }
        }
    }
    @discardableResult
    func addTouchUpInSideBtnAction(_ action:@escaping BtnAction) -> UIButton{
        self.DIY_button_add(action: action, for: .touchUpInside)
        return self
    }
    @discardableResult
    func addTouchUpOutSideBtnAction(_ action:@escaping BtnAction) -> UIButton{
        self.DIY_button_add(action: action, for: .touchUpOutside)
        return self
    }
    
    /// 倒计时
    func countDown(second: NSInteger) {
        //倒计时时间
        var timeout = second
        let queue:DispatchQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        let _timer:DispatchSource = DispatchSource.makeTimerSource(flags: [], queue: queue) as! DispatchSource
        _timer.schedule(wallDeadline: DispatchWallTime.now(), repeating: .seconds(1))
        // 每秒执行
        _timer.setEventHandler(handler: { () -> Void in
            if(timeout<=0){ //倒计时结束，关闭
                _timer.cancel();
                DispatchQueue.main.sync(execute: { () -> Void in
                    self.setTitle(self.reSendTitle, for: .normal)
                    self.isEnabled = true
                })
            }else{ // 正在倒计时
                let seconds = timeout
                DispatchQueue.main.sync(execute: { () -> Void in
                    let str = String(describing: seconds)
                    if self.countDownTitleSuf == "" {
                        self.setTitle("\(self.countDownTitlePre)\(str)s", for: .normal)
                    }else {
                        self.setTitle("\(self.countDownTitlePre)\(str)\(self.countDownTitleSuf)", for: .normal)
                    }
                    self.isEnabled = false
                })
                timeout -= 1;
            }
        })
        _timer.resume()
    }
    
    /// 添加下划线
    func setUnderlineStyle(color: UIColor? = nil, style: Int = NSUnderlineStyle.single.rawValue) {
        let attributedString = NSMutableAttributedString(string: self.titleLabel?.text ?? "")
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: style, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.underlineColor, value: color ?? (self.titleLabel?.textColor ?? BlackColor), range: NSRange(location: 0, length: attributedString.length))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}

/// gei button 添加一个属性 用于记录点击tag
private struct AssociatedKeys{
    static var actionKey = "actionKey"
    static var expandSizeKey = "expandSizeKey"
    static var countDownTitlePreKey = "countDownTitlePreKey"
    static var countDownTitleSufKey = "countDownTitleSufKey"
    static var countDownReSendTitleKey = "countDownReSendTitleKey"
    static var countDownIsClickDelayKey = "countDownIsClickDelayKey"
}

