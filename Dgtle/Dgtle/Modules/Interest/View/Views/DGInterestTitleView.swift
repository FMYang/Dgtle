//
//  DGInterestTitleView.swift
//  Dgtle
//
//  Created by yfm on 2019/7/19.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

protocol DGInterestTitleViewDelegate: class {
    func didSelected(index: Int)
}

class DGInterestTitleView: UIView {
    
    var btnWidth = 0.0
    let btnHeight = 40.0
    let slideWidth = 30.0
    let slideHeight = 2.0
    var titles: [String] = []
    var items: [UIButton] = []
    
    weak var delegate: DGInterestTitleViewDelegate?
    
    lazy var sliderView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: btnHeight - 6, width: slideWidth, height: slideHeight))
        view.backgroundColor = .black
        return view
    }()
    
    init(width: Double, titles: [String]) {
        super.init(frame: .zero)
        btnWidth = width / Double(titles.count)
        self.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 40.0)
        self.titles = titles
        layoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutUI() {
        addItems()
        sliderView.sp.centerX = items[0].sp.centerX
    }
    
    func addItems() {
        for i in 0..<titles.count {
            let button = UIButton(frame: CGRect(x: Double(i) * btnWidth, y: 0, width: btnWidth, height: btnHeight))
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.setTitleColor(.black, for: .selected)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.tag = i
            button.addTarget(self, action: #selector(buttonClick(btn:)), for: .touchUpInside)
            items.append(button)
            addSubview(button)
        }
        
        addSubview(sliderView)
    }
    
    @objc func buttonClick(btn: UIButton) {
        let index = btn.tag
        
        delegate?.didSelected(index: index)
    }
    
    /// 改变选择样式
    func changeSelectedItem(index: Int) {
        items.forEach { item in
            item.isSelected = false
        }
        
        items[index].isSelected = true

        UIView.animate(withDuration: 0.25) {
            self.sliderView.sp.centerX = self.items[index].sp.centerX
        }
    }
}
