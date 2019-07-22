//
//  DGMineViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

class DGMineViewModel {
    
    private var datasource = [[DGMineHomeItemType]]()
    
    init() {
        datasource = self.createDatasource()
    }
    
    func createDatasource() -> [[DGMineHomeItemType]] {
        let section0: [DGMineHomeItemType] = [.userInfo]
        let section1: [DGMineHomeItemType] = [.myCreation, .myIdle, .myCollect, .draftBox]
        let section2: [DGMineHomeItemType] = [.skin, .download, .advise, .setting]
        return [section0, section1, section2]
    }
    
    func numberOfSections() -> Int {
        return datasource.count
    }
    
    func numberOfRows(section: Int) -> Int {
        return datasource[section].count
    }
    
    func getType(indexPath: IndexPath) -> DGMineHomeItemType {
        return datasource[indexPath.section][indexPath.row]
    }
}
