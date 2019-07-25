//
//  DGHomeViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/13.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit
import RxSwift
import FSPagerView

class DGHomeViewController: UIViewController {
        
    let viewModel = DGHomeViewModel()
    let bag = DisposeBag()
    var datasource = [DGHomeListItem]()
    var banners = [DGHomeBannerItem]()
    var page = 1
    var isMenuShow = false
    var navAnimationDuring = 0.25
    var navRightAnimations = (0...25).map { return UIImage(named: String(format: "classifity_item_000%02d", $0))! }
    var navRightAnimationsReversed: [UIImage] = []
    
    lazy var logoView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "nav_logo"))
        return view
    }()
    
    lazy var navRightView: UIImageView = {
        let rightView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        rightView.image = UIImage(named: "classifity_item_00000")
        rightView.animationImages = navRightAnimations
        rightView.animationRepeatCount = 1
        rightView.animationDuration = navAnimationDuring
        rightView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(showOrHideMenu))
        rightView.addGestureRecognizer(tap)
        return rightView
    }()
    
    lazy var pagerView: FSPagerView = {
        let view = FSPagerView(frame: CGRect(x: 0, y: 10, width: screen_width, height: 200))
        view.dataSource = self
        view.delegate = self
        view.itemSize = CGSize(width: screen_width-40, height: 200)
        view.interitemSpacing = 10 // item之间的间距
        view.isInfinite = true // 是否无限循环
        view.automaticSlidingInterval = 2 // 自动翻页时间间隔
        view.register(DGHomeBannerCell.self, forCellWithReuseIdentifier: "banner")
        return view
    }()
    
    lazy var pagerControl: FSPageControl = {
        let view = FSPageControl(frame: CGRect(x: 0, y: 180, width: screen_width, height: 20))
        // 自定义control形状和大小，默认是圆形，宽高为itemSpacing
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 5, height: 5))
        view.setPath(path, for: .normal)
        view.setPath(path, for: .selected)
        view.setFillColor(.gray, for: .normal)
        view.setFillColor(.white, for: .selected)
        return view
    }()
    
    lazy var pagerTitleView: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 210, width: screen_width, height: 30))
        label.textAlignment = .center
        label.textColor = UIColor(valueRGB: 0x999999)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    lazy var topView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: screen_width, height: 240))
        view.backgroundColor = .white
        return view
    }()
    
    lazy var tableView: TDRefreshTableView = {
        let view = TDRefreshTableView(frame: .zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.estimatedRowHeight = 400
        view.separatorStyle = .none
        view.sp.registerCellFromNib(cls: DGHomeNewsCell.self)
        view.sp.registerCellFromNib(cls: DGHomeArticleTopicCell.self)
        view.sp.registerCellFromNib(cls: DGHomeArticleCell.self)
        view.sp.registerCellFromNib(cls: DGHomeGroupCell.self)
        view.sp.registerCellFromNib(cls: DGHomeNewsReadCell.self)
        view.sp.registerCellFromNib(cls: DGHomeWordCell.self)
        view.refreshDelegate = self
        view.sp.addHeader()
        view.sp.addFooter()
        return view
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navRightAnimationsReversed = navRightAnimations.reversed()
        
        layoutUI()
        setupNavigationBar()
        fetchBanners()
        tableView.startHeaderRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - action
    func setupNavigationBar() {
        navigationItem.titleView = logoView
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(searchAction))
        
        let rightBtn = UIBarButtonItem(customView: navRightView)
        rightBtn.customView?.widthAnchor.constraint(equalToConstant: 18).isActive = true
        rightBtn.customView?.heightAnchor.constraint(equalToConstant: 18).isActive = true
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    @objc func searchAction() {
        DGSearchView.show()
    }
    
    @objc func showOrHideMenu() {
        guard !navRightView.isAnimating else { return }
        
        if isMenuShow {
            // close menu
            navRightView.animationImages = navRightAnimationsReversed
            self.navRightView.image = self.navRightAnimations.first
            navRightView.startAnimating()
        } else {
            // open menu
            navRightView.animationImages = navRightAnimations
            self.navRightView.image = self.navRightAnimations.last
            navRightView.startAnimating()
        }
        isMenuShow = !isMenuShow
    }
    
    // MARK: - layout UI
    func layoutUI() {
        topView.addSubview(pagerView)
        pagerView.addSubview(pagerControl)
        topView.addSubview(pagerTitleView)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - network
    func fetchBanners() {
        viewModel.fetchBanner()
            .subscribe(onNext: { [weak self] (banners) in
                self?.banners = banners
                self?.pagerControl.numberOfPages = banners.count
                self?.pagerView.reloadData()
            }, onError: { _ in
                print("fetch banner error")
            })
            .disposed(by: bag)
    }
    
    func fetchList() {
        viewModel.fetchData(page: self.page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.page == 1 {
                    self?.datasource.removeAll()
                }
                self?.datasource += result
                self?.page += 1
                self?.tableView.reloadData()
                self?.tableView.endRefresh()
            }, onError: { [weak self] _ in
                self?.tableView.endRefresh()
            })
            .disposed(by: bag)
    }
    
}

// MARK: - tableView
extension DGHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datasource[indexPath.row]
        let type = DGHomeCellType(rawValue: model.type ?? "news") ?? .news
        let cell = DGHomeListCell.cell(tableView: tableView, type: type, indexPath: indexPath)
        cell.configCell(model: model)
        return cell as! UITableViewCell
    }
}

extension DGHomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let id = datasource[indexPath.row].aid ?? ""
        let vc = DGHomeDetailViewController(aid: id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return topView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
}

// MARK: - banner
extension DGHomeViewController: FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return banners.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "banner", at: index) as! DGHomeBannerCell
        cell.layer.cornerRadius = 4
        cell.layer.masksToBounds = true
        let item = banners[index]
        cell.imgView.sp.setImage(path: item.pic_url ?? "")
        return cell
    }
}

extension DGHomeViewController: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
        pagerControl.currentPage = index
        pagerTitleView.text = banners[index].title
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

// MARK: - refresh delegate
extension DGHomeViewController: TDRefreshDelegate {
    func beginHeaderRefresh() {
        page = 1
        fetchList()
    }
    
    func beginFooterRefresh() {
        fetchList()
    }
}
