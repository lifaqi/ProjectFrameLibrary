//
//  BaseViewController.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/5.
//

import UIKit

open class BaseViewController: UIViewController {
    public static var navigationBarColor = rgba(245, 245, 245, 1)
    public static var titleColor = rgba(34, 34, 34, 1)
    public static var leftTitleColor = rgba(148, 150, 151, 1)
    public static var rightTitleColor = rgba(148, 150, 151, 1)
    
    public let group = AsyncGroup()
    
    /// 是否禁用侧滑返回，默认是：false
    public var isDisabledSideSlip: Bool = false
    
    // view
    public var headerView: UIView!
    public var baseTitleLbl: UILabel!
    public var leftBtn: UIButton!
    public var rightBtn: UIButton!
    
    // data
    public var baseNavTitle: String?
    private var _isHiddenHeaderView = true
    public var isHiddenHeaderView: Bool {
        get {
            return _isHiddenHeaderView
        }
        set {
            _isHiddenHeaderView = newValue
            
            headerView.isHidden = _isHiddenHeaderView
        }
    }
    
    lazy var emptyView: UIView = {
        let view = UIView()
        view.layer.zPosition = 1
        return view
    }()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isDisabledSideSlip {
            self.popGestureClose()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isDisabledSideSlip {
            self.popGestureOpen()
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255, a: 1)

        self.mainNavView()
        
        initData()
        setupView()
        loadData()
        
        initConfig()
        
        self.view.bringSubviewToFront(headerView)
    }
    
    // MARK: - initConfig
    final func initConfig() {
        
    }
    
    // MARK: - setupView
    func mainNavView() {
        // headerView
        headerView = UIView()
        headerView.backgroundColor = BaseViewController.navigationBarColor;
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(HeaderHeight)
        }
        
        // baseTitleLbl
        baseTitleLbl = UILabel()
        baseTitleLbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        baseTitleLbl.textColor = BaseViewController.titleColor
        baseTitleLbl.text = baseNavTitle ?? ""
        headerView.addSubview(baseTitleLbl)
        baseTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(StatusBarHeight)
            make.height.equalTo(NavigationBarHeight)
            make.centerX.equalTo(headerView)
        }
        
        // leftBtn
        leftBtn = UIButton()
        leftBtn.titleLabel?.font = UIFont .systemFont(ofSize: 15)
        leftBtn.setTitleColor(BaseViewController.leftTitleColor, for: .normal)
        leftBtn.addTarget(self, action: #selector(clickLeftButtonEvent), for: .touchUpInside)
        headerView.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(StatusBarHeight)
            make.width.equalTo(50.ad)
            make.height.equalTo(NavigationBarHeight)
        }
        // 判断初始化页面时是否显示leftBtn
        if (self.navigationController == nil) {
            if (leftBtn != nil) {
                leftBtn.setImage(ToolKit.bundleForImage(imageName: "left_black@2x.png"), for: .normal)
            }
        }else {
            if (leftBtn != nil && (self.navigationController?.viewControllers.count)! > 1) {
                leftBtn.setImage(ToolKit.bundleForImage(imageName: "left_black@2x.png"), for: .normal)
            }
        }
        
        // rightBtn
        rightBtn = UIButton()
        rightBtn.titleLabel?.font = UIFont .systemFont(ofSize: 15)
        rightBtn.contentHorizontalAlignment = .center
        rightBtn.setTitleColor(BaseViewController.rightTitleColor, for: .normal)
        rightBtn.isUserInteractionEnabled = false
        rightBtn.addTarget(self, action: #selector(clickRightButtonEvent), for: .touchUpInside)
        headerView.addSubview(rightBtn)
        rightBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.equalTo(StatusBarHeight)
//            make.width.equalTo(60.ad)
            make.height.equalTo(NavigationBarHeight)
        }
    }
    
    /// 初始化数据
    open func initData() {
        
    }
    
    /// 构建UI
    open func setupView() {
        
    }
    
    /// 请求数据，刷新页面
    open func loadData() {
        
    }
    
    // MARK: - data source
    public var navTitle: String? {
        didSet {
            baseTitleLbl.text = navTitle
        }
    }
    
    public var leftTitle: String? {
        didSet {
            leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    public var leftImage: String? {
        didSet {
            leftBtn.setImage(UIImage(named: leftImage!), for: .normal)
        }
    }
    
    public var rightTitle: String? {
        didSet {
            rightBtn.isUserInteractionEnabled = true
            rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    public var rightImage: String? {
        didSet {
            rightBtn.isUserInteractionEnabled = true
            rightBtn.setImage(UIImage(named: rightImage!), for: .normal)
        }
    }
    
    // MARK: - func
    @objc open func clickLeftButtonEvent(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc open func clickRightButtonEvent(sender: UIButton) {
        
    }
    
    public func showLeftBtn() {
        self.view.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(StatusBarHeight)
            make.width.equalTo(50.ad)
            make.height.equalTo(NavigationBarHeight)
        }
    }
    
    public func setupEmptyView(image: UIImage?, info: String, font: UIFont = .systemFont(ofSize: 14)) {
        // emptyView
        self.view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.centerY.equalTo(self.view.snp.centerY)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        for itemView in emptyView.subviews {
            itemView.removeFromSuperview()
        }
        
        // iconIv
        let iconIv = UIImageView.createImageView()
        iconIv.image = image
        emptyView.addSubview(iconIv)
        iconIv.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.centerX.equalTo(emptyView.snp.centerX)
        }
        
        // tipLbl
        let tipLbl = UILabel.createLabel()
        tipLbl.font = font
        tipLbl.text = info
        emptyView.addSubview(tipLbl)
        tipLbl.snp.makeConstraints { make in
            make.top.equalTo(iconIv.snp.bottom).offset(18.ad)
            make.centerX.equalTo(emptyView.snp.centerX)
        }
    }
}
