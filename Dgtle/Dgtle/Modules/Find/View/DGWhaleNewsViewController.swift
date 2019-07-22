//
//  DGWhaleNewsViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGWhaleNewsViewController: UIViewController {
    
    var page: Int = 1
    var datasource = [DGWhaleNewsItem]()
    var viewModel = DGWhaleNewsViewModel()
    let bag = DisposeBag()
    
    lazy var tableView: TDRefreshTableView = {
        let view = TDRefreshTableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor(valueRGB: 0xf2f2f2)
        view.sp.registerCellFromNib(cls: DGWhaleNewsDefaultCell.self)
        view.sp.registerCellFromNib(cls: DGWhaleNewsWordCell.self)
        view.sp.registerCellFromNib(cls: DGWhaleNewsReadCell.self)
        view.estimatedRowHeight = 300
        view.separatorStyle = .none
        view.refreshDelegate = self
        view.sp.addHeader()
        view.sp.addFooter()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        tableView.startHeaderRefresh()
    }
    
    func layoutUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func fetchList() {
        viewModel.fetchWhaleNews(page: page)
            .subscribe(onNext: { [weak self] (result) in
                if self?.page == 1 {
                    self?.datasource = result?.list ?? []
                } else {
                    self?.datasource += result?.list  ?? []
                }
                self?.tableView.reloadData()
                self?.tableView.endRefresh()
                self?.page += 1
            }, onError: { [weak self] _ in
                print("fetch news error")
                self?.tableView.endRefresh()
            })
            .disposed(by: bag)
    }
}


extension DGWhaleNewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = datasource[indexPath.row]
        let style = DGWhaleNewsCell.getType(name: item.type ?? "")
        let cell = DGWhaleNewsCell.dequeueCell(tableView: tableView,
                                               style: style,
                                               indexPath: indexPath)
        cell.configCell(item: item)
        return cell as! UITableViewCell
    }
}

extension DGWhaleNewsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
}

// MARK: - refresh delegate
extension DGWhaleNewsViewController: TDRefreshDelegate {
    func beginHeaderRefresh() {
        page = 1
        fetchList()
    }
    
    func beginFooterRefresh() {
        fetchList()
    }
}
