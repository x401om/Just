//
//  ViewController.swift
//  Just
//
//  Created by Aleksey Goncharov on 29.01.17.
//  Copyright © 2017 Just. All rights reserved.
//

import UIKit
import WebKit

import BoltsSwift

class ViewController: UIViewController {
  
  var item: RSSItem? = nil
  
  weak var webView: WKWebView!

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let webView = WKWebView(frame: self.view.bounds)
    self.view .addSubview(webView)
    self.webView = webView
    
    if let item = self.item {
      load(item: item)
    }
//    let url = Bundle.main.url(forResource: "iphones", withExtension: "html");
//    do {
//      let html = try String(contentsOf: url!, encoding: String.Encoding.utf8)
//      self.webView.loadHTMLString(html, baseURL: nil)
//    } catch {
//      
//    }
  }
  
  func load(item: RSSItem) {
    
    if let cssFileUrl = Bundle.main.url(forResource: "style", withExtension: "css") {
      do {
        let style = try String(contentsOf: cssFileUrl, encoding: String.Encoding.utf8)
        let fullHTML = "<style>\(style)</style><h1 align=\"center\">\(item.title)</h1><div>\(item.content)</div>"
        self.webView.loadHTMLString(fullHTML, baseURL: nil)
      } catch {
        
      }
    }
  }

//  @IBAction func loadButtonPressed(sender: UIButton) {
//
//    let articleUrl = ""
//
//    if (articleUrl != nil) {
//      let parser = PageParser()
//      parser.fetchArticleWithUrl(urlString: articleUrl).continueWith { task in
//        var html = task.result!
//        html = "<head><style> P {font-size: 170%;font-family: Verdana, Arial, Helvetica, sans-serif}</style></head>".appending(html)
//        
//        self.webView.loadHTMLString(html, baseURL: nil)
//      }
//    }
//  }
}

