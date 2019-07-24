//
//  DGHomeArticleTopicCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/23.
//  Copyright © 2019 yfm. All rights reserved.
//
//  文章专题

import UIKit

class DGHomeArticleTopicCell: UITableViewCell {
    @IBOutlet weak var topicTypeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkTopicButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: DGHomeListItem?
    var groupDatasource = [DGHomeListItem]()
    var articleDatasource = [DGHomeTopicArticleItem]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "DGHomeTopicCollectionCell", bundle: nil), forCellWithReuseIdentifier: "topic_Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DGHomeArticleTopicCell: DGHomeCellProtocol {
    func configCell(model: DGHomeListItem) {
        self.model = model
        
        titleLabel.text = model.title
        
        if model.type == "article_topic" {
            topicTypeLabel.text = "文章专题"
            articleDatasource = model.topic_article?.list ?? []
        } else { // group_topic
            topicTypeLabel.text = "兴趣专题"
            groupDatasource = model.topic_group?.list ?? []
        }
        collectionView.reloadData()

    }
}

extension DGHomeArticleTopicCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (model?.type == "article_topic") ? articleDatasource.count : groupDatasource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topic_Cell", for: indexPath) as! DGHomeTopicCollectionCell
        if (model?.type == "article_topic") {
            cell.configCell(article: articleDatasource[indexPath.row])
        } else {
            cell.configCell(model: groupDatasource[indexPath.row])
        }
        return cell
    }
}

extension DGHomeArticleTopicCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension DGHomeArticleTopicCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 195)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
