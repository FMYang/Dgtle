//
//  DGInterestListViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/19.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit
import Kingfisher
import SKPhotoBrowser

class DGInterestListViewController: UIViewController {

    var newPage: Int = 1
    var hotPage: Int = 1
    var newDatasource = [DGInterestItemProtocol]()
    var hotDatasource = [DGInterestItemProtocol]()
    var newViewModel = DGInterestNewViewModel()
    let bag = DisposeBag()
    var animationView: UIImageView?
    var listType: DGInterestListControllerType = .new
    
    lazy var tableView: TDRefreshTableView = {
        let view = TDRefreshTableView(frame: .zero, style: .grouped)
        view.delegate = self
        view.dataSource = self
        view.sp.registerCell(cls: DGInterestCellStyle1.self)
        view.sp.registerCell(cls: DGInterestCellStyle2.self)
        view.sp.registerCell(cls: DGInterestCellStyle3.self)
        view.sp.registerCell(cls: DGInterestCellStyle4.self)
        view.sp.registerCell(cls: DGInterestCellStyle5.self)
        view.sp.registerCell(cls: DGInterestCellStyle6.self)
        view.sp.registerCell(cls: DGInterestCellStyle7.self)
        view.sp.registerCell(cls: DGInterestCellStyle8.self)
        view.sp.registerCell(cls: DGInterestCellStyle9.self)
        view.estimatedRowHeight = 300
        view.separatorStyle = .none
        view.refreshDelegate = self
        view.sp.addHeader()
        view.sp.addFooter()
        return view
    }()
    
    convenience init(listType: DGInterestListControllerType) {
        self.init()
        self.listType = listType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        tableView.startHeaderRefresh()
        
        // Static setup
        SKPhotoBrowserOptions.displayAction = true
        SKPhotoBrowserOptions.displayStatusbar = true
        SKPhotoBrowserOptions.displayCounterLabel = true
        SKPhotoBrowserOptions.displayBackAndForwardButton = true
        
        SKCache.sharedCache.imageCache = CustomImageCache()
    }
    
    func layoutUI() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func fetchNewList(page: Int) {
        newViewModel.fetchNewList(page: page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.newPage == 1 {
                    self?.newDatasource = result
                } else {
                    self?.newDatasource += result
                }
                self?.tableView.reloadData()
                self?.tableView.endRefresh()
                self?.newPage += 1
                }, onError: { _ in
                    print("error")
            })
            .disposed(by: bag)
    }
    
    func fetchHotList(page: Int) {
        newViewModel.fetchHotList(page: page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.hotPage == 1 {
                    self?.hotDatasource = result
                } else {
                    self?.hotDatasource += result
                }
                self?.tableView.reloadData()
                self?.tableView.endRefresh()
                self?.hotPage += 1
                }, onError: { _ in
                    print("error")
            })
            .disposed(by: bag)
    }
}

extension DGInterestListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listType == .new ? newDatasource.count : hotDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listType == .new ? newDatasource[indexPath.row] : hotDatasource[indexPath.row]
        let count = item.attach_count ?? 1
        let style: DGInterestCellStyle = DGInterestCellStyle(rawValue: count) ?? .style1
        let cell = DGInterestCell.dequenceCell(tableView: tableView, style: style, indexPath: indexPath)
        cell.delegate = self
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configCell(item: item)
        return cell
    }
}

extension DGInterestListViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}

// MARK: - refresh delegate
extension DGInterestListViewController: TDRefreshDelegate {
    func beginHeaderRefresh() {
        if listType == .new {
            newPage = 1
            fetchNewList(page: newPage)
        } else {
            hotPage = 1
            fetchHotList(page: hotPage)
        }
    }
    
    func beginFooterRefresh() {
        if listType == .new {
            fetchNewList(page: newPage)
        } else {
            fetchHotList(page: hotPage)
        }
    }
}

extension DGInterestListViewController: DGInterestCellDelegate {
    func didClickImage(selected: Int, at indexPath: IndexPath?, imageView: UIImageView) {
        guard let row = indexPath?.row else { return }
        let item = listType == .new ? newDatasource[row] : hotDatasource[row]
        let picUrls: [String] = item.attachment?.values.map { return $0 } ?? []
        
        let skPhotos = picUrls.map { url -> SKPhotoProtocol in
            let photo = SKPhoto.photoWithImageURL(url, holder: UIImage(named: "default"))
            photo.shouldCachePhotoURLImage = true
            return photo
        }
        
        animationView = imageView
        if skPhotos.count > 0 {
            /// animatedFromView 执行动画的视图
            let brower = SKPhotoBrowser(originImage: imageView.image ?? UIImage(), photos: skPhotos, animatedFromView: imageView)
            brower.initializePageIndex(selected)
            brower.delegate = self
            present(brower, animated: true, completion: nil)
        }
    }
}

class CustomImageCache: SKImageCacheable {
    //    var cache: SDImageCache // sd
    var cache: ImageCache
    
    init() {
        //        let cache = SDImageCache.shared() // sd
        let cache = KingfisherManager.shared.cache
        self.cache = cache
    }
    
    func imageForKey(_ key: String) -> UIImage? {
        //        guard let image = cache.imageFromDiskCache(forKey: key) else { return nil } // sd
        guard let image = cache.retrieveImageInDiskCache(forKey: key) else { return nil }
        
        return image
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        //        cache.store(image, forKey: key) //sd
        cache.store(image, forKey: key)
    }
    
    func removeImageForKey(_ key: String) {}
    
    func removeAllImages() {}
    
}

extension DGInterestListViewController: SKPhotoBrowserDelegate {
    // brower消失的时候代理，返回动画视图，如果不实现，消失的时候没有缩放动画
    func viewForPhoto(_ browser: SKPhotoBrowser, index: Int) -> UIView? {
        guard animationView != nil else { return nil }
        return animationView
    }
}
