//
//  DGHomeDetailViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit
import WebKit

class DGHomeDetailViewController: UIViewController {
    
    let viewModel = DGHomeDetailViewModel()
    let bag = DisposeBag()
    var aid: String = ""
    var htmlTemplate: String?
    
    lazy var webView: WKWebView = {
        let view = WKWebView.init(frame: .zero)
        view.backgroundColor = .white
        view.uiDelegate = self
        view.navigationDelegate = self
        return view
    }()
    
    lazy var bottomTool: DGDetailBottomTool = {
        let view = Bundle.main.loadNibNamed("DGDetailBottomTool", owner: nil, options: nil)?.first as! DGDetailBottomTool
        return view
    }()
    
    convenience init(aid: String) {
        self.init()
        self.aid = aid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        fetchDetail()
    }
    
    deinit {
        webView.removeFromSuperview()
        webView.uiDelegate = nil
        webView.navigationDelegate = nil
    }
    
    func layoutUI() {
        self.view.addSubview(webView)
        self.view.addSubview(bottomTool)
        webView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        bottomTool.snp.makeConstraints { (make) in
            make.top.equalTo(webView.snp.bottom)
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func fetchDetail() {
        viewModel.fetchDetail(aid: aid).subscribe(onNext: { (result) in
            self.loadHTMLContent(model: result)
        }, onError: { _ in
            print("error")
        })
        .disposed(by: bag)
    }
    
    func loadHTMLContent(model: DGArticleModel?) {
        let content = model?.returnData?.article_content?.content ?? ""
        let htmlTitleImage = getTtitleImageHTMLString(model: model)
        let htmlTitle = getTitleHTMLString(model: model)
        let htmlSubTitle = getSubTitleHTMLString(model: model)
        let authorInfo = getAuthorInfoHTMLString(model: model)
        let comment = getCommentHTMLString(model: model)
        
        let htmlTemplatePath = Bundle.main.path(forResource: "article", ofType: "html") ?? ""
        let basePath = URL(fileURLWithPath: htmlTemplatePath)
        htmlTemplate = try? String(contentsOfFile: htmlTemplatePath, encoding: .utf8)
        let variables = ["<!-- title image -->": htmlTitleImage,
                         "<!-- device size -->": "\(screen_width)",
                         "<!-- title width -->": "\(screen_width-80)",
                        "<!-- title font size -->": "24",
                        "<!-- subtitle align -->": "center",
                        "<!-- article title -->": htmlTitle,
                        "<!-- article subtitle -->": htmlSubTitle,
                        "<!-- authorinfo -->": authorInfo,
                        "<!-- commentlist -->": comment]
        repalcePlaceholder(html: &htmlTemplate, variables: variables)
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- article content -->", with: content)
        // 重要：一定要设置baseURL，否则本地js和css加载可能有问题（如jquery找不到等问题）
        webView.loadHTMLString(htmlTemplate ?? "", baseURL: basePath)
    }
    
    /// 文章顶部图片HTML
    func getTtitleImageHTMLString(model: DGArticleModel?) -> String {
        let picUrl = model?.returnData?.articledata?.pic ?? ""
        let htmlTitleImage = """
        <img src=\(picUrl) style="width:\(screen_width)px; height:auto;">
        """
        return htmlTitleImage
    }
    
    /// 标题HTML
    func getTitleHTMLString(model: DGArticleModel?) -> String {
        let title = model?.returnData?.articledata?.title ?? ""
        let htmlTitle = """
        <div id="title">\(title)</div>
        """
        return htmlTitle
    }
    
    /// 子标题HTML
    func getSubTitleHTMLString(model: DGArticleModel?) -> String {
        let author = model?.returnData?.articledata?.author ?? ""
        let catname = model?.returnData?.catdata?.catname ?? ""
        let timestamp = model?.timestamp ?? 0
        let date = String.toString(timeStamp: timestamp, format: "yyyy-MM-dd")
        
        let htmlSubTitle = """
        <div style="width:\(screen_width)px; color:#909090; text-align: center; font-size: 12px;">\(catname)·\(author)·\(date)</div>
        """
        
        return htmlSubTitle
    }
    
    /// 作者信息HTML
    func getAuthorInfoHTMLString(model: DGArticleModel?) -> String {
        let author = model?.returnData?.articledata?.author ?? ""
        let authorid = model?.returnData?.articledata?.authorid ?? ""
        let authorBio = model?.returnData?.articledata?.bio ?? ""
        let avatar = "http://www.dgtle.com/uc_server/avatar.php?uid=\(authorid)"

        let authorInfo = """
        <div id="author_info">
            <div class="sign">
                <a style="color: black">文章作者</a>
            </div>
            <div class="author">
                <span><img src=\(avatar)></span>
                <span>\(author)</span>
            </div>
            <div class="follow">
                关注
            </div>
            <div class="sign">
            <span><a>\(authorBio)</a></span>
            </div>
        </div>
        """
        
        return authorInfo
    }
    
    /// 评论HTML
    func getCommentHTMLString(model: DGArticleModel?) -> String {
        var comments: [DGCommentModel] = model?.returnData?.commentlist?.values.map { return $0 } ?? []
        guard comments.count > 0 else { return "" }
        if comments.count > 3 {
            comments = [] + comments.prefix(3)
        }
        
        var commentList = ""
        comments.forEach({ (item) in
            let avatar = "http://www.dgtle.com/uc_server/avatar.php?uid=\(item.authorid ?? "")"
            let author = item.author ?? ""
            let date = String.timeStampToString(timeStamp: item.dateline ?? 0.0)
            let content = item.message ?? ""
            let str = """
            <div class="comment_">
                <div class="avatar">
                    <img src=\(avatar)>
                </div>
                <div class="box">
                    <div style="display:inline;">
                        <div class="author">\(author)</div>
                        <div class="author_date">\(date)</div>
                    </div>
                    <div class="content">
                    \(content)
                    </div>
                </div>
            </div>
            """
            commentList += str
        })

        let htmlString = """
        <div id="comment">
            <div class="comment_title">
                最新评论 \(comments.count)
            </div>
            <div class="comment_list">
                \(commentList)
            </div>
            <button style="width: \(screen_width-40)px; height: 35px; line-height: 15px; font-size:12px;padding: 10px 0; border:none;text-align: center; color: #fff;background: #469de6;margin: 20px;">
                查看所有 \(comments.count) 条评论
            </button>
        </div>
        """
        
        return htmlString
    }
    
    /// 替换HTML占位符
    ///
    /// - Parameters:
    ///   - html: html字符串
    ///   - variables: 替换的变量字典（key为占位符，value为新值）
    func repalcePlaceholder( html: inout String?, variables: [String: String]) {
        for (key, value) in variables {
            html = html?.replacingOccurrences(of: key, with: value)
        }
    }
}

extension DGHomeDetailViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print(message)
        completionHandler()
    }
}

extension DGHomeDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 调用js方法，裁剪详情H5图片
        // TODO: 懒加载图片
        let jsMehod = String(format: "imgWidth('#v-main')")
        webView.evaluateJavaScript(jsMehod)
    }
}
