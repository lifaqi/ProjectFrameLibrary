//
//  BaseNavigationController.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/5.
//

import UIKit

open class BaseNavigationController: UIViewController {
    static var navigationBarColor = UIColor(r: 245, g: 245, b: 245, a: 1)
    static var titleColor = UIColor(r: 245, g: 245, b: 245, a: 1)
    static var leftTitleColor = UIColor(r: 245, g: 245, b: 245, a: 1)
    static var rightTitleColor = UIColor(r: 245, g: 245, b: 245, a: 1)
    
    let group = AsyncGroup()
    
    /// 是否禁用侧滑返回，默认是：false
    var isDisabledSideSlip: Bool = false
    
    // view
    var headerView: UIView!
    var baseTitleLbl: UILabel!
    var leftBtn: UIButton!
    var rightBtn: UIButton!
    
    // data
    var baseNavTitle: String?
    private var _isHiddenHeaderView = true
    var isHiddenHeaderView: Bool {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isDisabledSideSlip {
            self.popGestureClose()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isDisabledSideSlip {
            self.popGestureOpen()
        }
    }

    override func viewDidLoad() {
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
        headerView.backgroundColor = BaseNavigationController.navigationBarColor;
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(HeaderHeight)
        }
        
        // baseTitleLbl
        baseTitleLbl = UILabel()
        baseTitleLbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        baseTitleLbl.textColor = BaseNavigationController.titleColor
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
        leftBtn.setTitleColor(BaseNavigationController.leftTitleColor, for: .normal)
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
                leftBtn.setImage(UIImage(named: "left_black"), for: .normal)
            }
        }else {
            if (leftBtn != nil && (self.navigationController?.viewControllers.count)! > 1) {
                leftBtn.setImage(UIImage(named: "left_black"), for: .normal)
            }
        }
        
        // rightBtn
        rightBtn = UIButton()
        rightBtn.titleLabel?.font = UIFont .systemFont(ofSize: 15)
        rightBtn.contentHorizontalAlignment = .center
        rightBtn.setTitleColor(BaseNavigationController.rightTitleColor, for: .normal)
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
    func initData() {
        
    }
    
    /// 构建UI
    func setupView() {
        
    }
    
    /// 请求数据，刷新页面
    func loadData() {
        
    }
    
    // MARK: - data source
    var navTitle: String? {
        didSet {
            baseTitleLbl.text = navTitle
        }
    }
    
    var leftTitle: String? {
        didSet {
            leftBtn.setTitle(leftTitle, for: .normal)
        }
    }
    
    var leftImage: String? {
        didSet {
            leftBtn.setImage(UIImage(named: leftImage!), for: .normal)
        }
    }
    
    var rightTitle: String? {
        didSet {
            rightBtn.isUserInteractionEnabled = true
            rightBtn.setTitle(rightTitle, for: .normal)
        }
    }
    
    var rightImage: String? {
        didSet {
            rightBtn.isUserInteractionEnabled = true
            rightBtn.setImage(UIImage(named: rightImage!), for: .normal)
        }
    }
    
    // MARK: - func
    @objc func clickLeftButtonEvent(sender: UIButton) {
        if self.navigationController == nil {
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func clickRightButtonEvent(sender: UIButton) {
        
    }
    
    func showLeftBtn() {
        self.view.addSubview(leftBtn)
        leftBtn.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(StatusBarHeight)
            make.width.equalTo(50.ad)
            make.height.equalTo(NavigationBarHeight)
        }
    }
    
    func setupEmptyView(image: UIImage?, info: String, font: UIFont = .systemFont(ofSize: 14)) {
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
