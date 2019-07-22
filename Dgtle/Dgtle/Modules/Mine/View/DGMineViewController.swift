//
//  DGMineViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/13.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGMineViewController: UIViewController {
    
    let viewModel = DGMineViewModel()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = UIColor(valueRGB: 0xf2f2f2)
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.sp.registerCellFromNib(cls: DGMineHomeCell.self)
        view.sp.registerCellFromNib(cls: DGMineUserInfoCell.self)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "个人信息"
        
        layoutUI()
    }
    
    func layoutUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

extension DGMineViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.sp.dequeueReuseCell(DGMineUserInfoCell.self, indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.sp.dequeueReuseCell(DGMineHomeCell.self, indexPath: indexPath)
            cell.config(type: viewModel.getType(indexPath: indexPath))
            if indexPath.row == viewModel.numberOfRows(section: indexPath.section) - 1 {
                cell.bottomLine.isHidden = true
            } else {
                cell.bottomLine.isHidden = false
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 75
        }
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15.0
        }
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }

}

extension DGMineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

