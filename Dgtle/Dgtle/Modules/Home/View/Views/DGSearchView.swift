//
//  DGSearchView.swift
//  Dgtle
//
//  Created by yfm on 2019/7/24.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGSearchView: UIView {
    
    private static var associatedKey = "search_view"
    
    var widthConstraint: Constraint?
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 4
        view.backgroundColor = UIColor(valueRGB: 0xf2f2f2)
        return view
    }()
    
    lazy var iconView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "nav_search_channel"))
        return view
    }()
    
    lazy var textfield: UITextField = {
        let view = UITextField()
        view.font = UIFont.systemFont(ofSize: 14)
        let str = NSAttributedString(string: "搜索你感兴趣的...")
        let attributeString = NSMutableAttributedString(attributedString: str)
        attributeString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12),
                                       NSAttributedString.Key.foregroundColor: UIColor(valueRGB: 0x999999)],
                                      range: NSRange(location: 0, length: str.length))
        view.attributedPlaceholder = attributeString
        view.textColor = UIColor(valueRGB: 0x333333)
        view.clearButtonMode = .whileEditing
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor(valueRGB: 0x333333), for: .normal)
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(valueRGB: 0xf2f2f2)

        layoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI() {
        searchView.addSubview(iconView)
        searchView.addSubview(textfield)
        topView.addSubview(searchView)
        topView.addSubview(cancelButton)
        addSubview(topView)
        
        topView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(IG_NaviHeight)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(27)
            make.width.equalTo(screen_width-150)
            make.height.equalTo(30)
        }
        
        iconView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(11)
        }
        
        textfield.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(7)
            make.bottom.equalTo(searchView.snp.bottom).offset(-5)
            make.left.equalTo(iconView.snp.right).offset(5)
            make.right.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.right)
            make.width.height.equalTo(40)
            make.centerY.equalTo(searchView)
        }
    }
    
    /// private method
    @objc private func cancel() {
        dismiss()
    }
    
    /// publick mehotd
    public static func show() {
        let view = DGSearchView()
        let window = UIApplication.shared.keyWindow
        view.frame = UIScreen.main.bounds
        objc_setAssociatedObject(self,
                                 &associatedKey,
                                 view,
                                 .OBJC_ASSOCIATION_RETAIN)
        view.layoutIfNeeded()
        window?.addSubview(view)
        
        view.textfield.becomeFirstResponder()
        UIView.animate(withDuration: 0.25) {
            view.searchView.snp.updateConstraints({ (make) in
                make.width.equalTo(screen_width - 70)
            })
            view.cancelButton.snp.updateConstraints({ (make) in
                make.left.equalTo(view.snp.right).offset(-50)
            })
            view.layoutIfNeeded()
        }
    }
    
    public static func dismiss() {
        let view = objc_getAssociatedObject(self, &associatedKey) as! DGSearchView
     
        view.removeFromSuperview()
    }
    
    public func dismiss() {
        DGSearchView.dismiss()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss()
    }
}
