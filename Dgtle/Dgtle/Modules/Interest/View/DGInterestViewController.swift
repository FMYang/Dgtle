//
//  DGInterestViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/13.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit


class DGInterestViewController: UIViewController {
    
    var childControllers: [UIViewController] = []
    let controllerTypes: [DGInterestListControllerType] = [.new, .hot]
    
    lazy var titleView: DGInterestTitleView = {
        let titles = controllerTypes.map { return $0.title }
        let view = DGInterestTitleView(width: 140, titles: titles)
        view.delegate = self
        return view
    }()
    
    lazy var containerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: IG_NaviHeight, width: screen_width, height: screen_height - IG_NaviHeight)
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitleView()
        layoutUI()
        addChildControllers()
        loadPage(viewController: childControllers[0], index: 0)
    }
    
    func layoutUI() {
        self.view.addSubview(containerView)
        
        containerView.contentSize = CGSize(width: CGFloat(controllerTypes.count) * screen_width,
                                           height: containerView.sp.height)
    }
    
    // MARK: - action
    func setNavTitleView() {
        navigationItem.titleView = titleView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(searchAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "write")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(writeAction))

    }
    
    @objc func searchAction() {
        
    }
    
    @objc func writeAction() {
        
    }
    
    func addChildControllers() {
        controllerTypes.forEach { type in
            let vc = DGInterestListViewController(listType: type)
            childControllers.append(vc)
        }
    }
    
    /// load page
    func loadPage(viewController: UIViewController, index: Int) {
        guard index >= 0, index < controllerTypes.count else {
            return
        }
        
        addChild(viewController)
        
        viewController.view.frame = CGRect(x: screen_width * CGFloat(index), y: 0.0, width: screen_width, height: screen_height - IG_NaviHeight - IG_TabbarHeight)
        containerView.addSubview(viewController.view)
    }
    
    /// change page
    func changeCurrentPage(_ index: Int) {
        guard index >= 0, index < controllerTypes.count else {
            return
        }
        titleView.changeSelectedItem(index: index)
        loadPage(viewController: childControllers[index], index: index)
        containerView.setContentOffset(CGPoint.init(x: CGFloat(index) * screen_width, y: 0), animated: false)
    }
}

extension DGInterestViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = lroundf(Float(scrollView.contentOffset.x / screen_width))
        changeCurrentPage(index)
    }
}

extension DGInterestViewController: DGInterestTitleViewDelegate {
    func didSelected(index: Int) {
        changeCurrentPage(index)
    }
}
