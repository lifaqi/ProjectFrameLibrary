//
//  SWYTextField.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2023/2/13.
//

import UIKit

class SWYTextField: UITextField {

    var underLineColor = BlackColor {
        didSet {
            self.layer.shadowColor = underLineColor.cgColor
        }
    }
    var selectUnderLineColor = BlackColor
    
    init(size: CGFloat = 16, textColor: UIColor = BlackColor, placeholder: String = "", style: UIFont.Weight = .regular) {
        super.init(frame: CGRect.zero)
        
        self.delegate = self
        self.font = UIFont.systemFont(ofSize: size, weight: style)
        self.textColor = textColor
        self.placeholder = placeholder
        
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        // 设置下划线
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

extension SWYTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.shadowColor = selectUnderLineColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.shadowColor = underLineColor.cgColor
    }
}
