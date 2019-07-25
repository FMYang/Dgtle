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
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
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
        let title = model?.returnData?.articledata?.title ?? ""
        let picUrl = model?.returnData?.articledata?.pic ?? ""
        let catname = model?.returnData?.catdata?.catname ?? ""
        let author = model?.returnData?.articledata?.author ?? ""
        let timestamp = model?.timestamp ?? 0
        let date = String.toString(timeStamp: timestamp, format: "yyyy-MM-dd")
        
        let htmlTitleImage = """
        <img src=\(picUrl) style="width:\(screen_width)px; height:auto;">
        """
        let htmlTitle = """
        <div id="title">\(title)</div>
        """
        let htmlSubTitle = """
        <div style="width:\(screen_width)px; color:#909090; text-align: center; font-size: 12px;">\(catname)·\(author)·\(date)</div>
        """
        
        let htmlTemplatePath = Bundle.main.path(forResource: "article", ofType: "html") ?? ""
        let basePath = URL(fileURLWithPath: htmlTemplatePath)
        htmlTemplate = try? String(contentsOfFile: htmlTemplatePath, encoding: .utf8)
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- title image -->", with: htmlTitleImage)
        // <!-- title width -->
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- title width -->", with: "\(screen_width-80)")
        // <!-- title font size -->
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- title font size -->", with: "24")
        // <!-- subtitle align -->
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- subtitle align -->", with: "center")
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- article title -->", with: htmlTitle)
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- article subtitle -->", with: htmlSubTitle)
        htmlTemplate = htmlTemplate?.replacingOccurrences(of: "<!-- article content -->", with: content)
        // 重要：一定要设置baseURL，否则本地js和css不加载（如jquery找不到等问题）
        webView.loadHTMLString(htmlTemplate ?? "", baseURL: basePath)
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
        let jsMehod = String(format: "imgWidth('#v-main')")
        webView.evaluateJavaScript(jsMehod) { (result, error) in
            print(result, error)
        }
    }
}
