//
//  DGWhaleImageViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGWhaleImageViewController: UIViewController {
    
    let reuseIdentifier = "whale_picture_cell"
    let itemWidth = (screen_width-30) / 2
    
    let bag = DisposeBag()
    let viewModel = DGWhaleImageViewModel()
    var datasource = [DGWhalePictureItem]()
    var page = 1
    
    lazy var collectionView: TDRefreshCollectionView = {
        let layout = DGWaterfallFlowLayout()
        let view = TDRefreshCollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor(valueRGB: 0xf2f2f2)
        view.delegate = self
        view.dataSource = self
        view.register(UINib(nibName: "DGWhalePictureCell", bundle: nil),
                      forCellWithReuseIdentifier: reuseIdentifier)
        view.refreshDelegate = self
        view.sp.addHeader()
        view.sp.addFooter()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        collectionView.startHeaderRefresh()
    }
    
    func layoutUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func fetchList() {
        viewModel.fetchWhaleImage(page: page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.page == 1 {
                    self?.datasource = result?.list ?? []
                } else {
                    self?.datasource += result?.list ?? []
                }
                self?.page += 1
                self?.collectionView.reloadData()
                self?.collectionView.endRefresh()
            }, onError: { [weak self] _ in
                print("error")
                self?.collectionView.endRefresh()
            })
            .disposed(by: bag)
    }
}

extension DGWhaleImageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DGWhalePictureCell
        let item = self.datasource[indexPath.row]
        cell.config(item: item)
        return cell
    }
}

extension DGWhaleImageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = self.datasource[indexPath.row]
        let imageHeight = item.height! / item.width! * Double(itemWidth)
        let cellHeight = imageHeight + 100
        return CGSize(width: itemWidth, height: CGFloat(cellHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

// MARK: - refresh delegate
extension DGWhaleImageViewController: TDRefreshDelegate {
    func beginHeaderRefresh() {
        page = 1
        fetchList()
    }
    
    func beginFooterRefresh() {
        fetchList()
    }
}
