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
    
    lazy var webView: WKWebView = {
        let view = WKWebView.init(frame: .zero)
        view.backgroundColor = .white
        view.uiDelegate = self
        return view
    }()
    
    convenience init(aid: String) {
        self.init()
        self.aid = aid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()

        viewModel.fetchDetail(aid: aid).subscribe(onNext: { (str) in
            self.loadHTMLContent(content: str)
        }, onError: { _ in
            print("error")
        })
        .disposed(by: bag)
    }
    
    func layoutUI() {
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func loadHTMLContent(content: String) {
        let htmlStr = """
        <html>
        <head>
        <style type=\"text/css\">
        body {font-size:45px;}
        </style>
        </head>
        <body>
        <script type='text/javascript'>
        window.onload = function() {
            var $img = document.getElementsByTagName('img');
            for(var p in  $img) {
                $img[p].style.width = '\(1000)';
                $img[p].style.height ='auto'
            }
        }
        </script>\(content)
        </body>
        </html>
        """
        
        webView.loadHTMLString(htmlStr, baseURL: nil)
    }

}

extension DGHomeDetailViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print(message)
        completionHandler()
    }
}
