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

  @IBOutlet weak var textField: UITextField!
  
  weak var webView: WKWebView!

  
  override func viewDidLoad() {
    super.viewDidLoad()

    self.textField.text = "https://www.iphones.ru/iNotes/app-store-and-mobile-games"
    
    let webView = WKWebView(frame: CGRect(x: 0, y: 60, width: 375, height: 600))
    self.view .addSubview(webView)
    self.webView = webView
    
    let url = Bundle.main.url(forResource: "iphones", withExtension: "html");
    do {
      let html = try String(contentsOf: url!, encoding: String.Encoding.utf8)
      self.webView.loadHTMLString(html, baseURL: nil)
    } catch {
      
    }
//    let request = URLRequest(url: url!)
//    self.webView.load(request)
  }

  @IBAction func loadButtonPressed(sender: UIButton) {
    self.textField.resignFirstResponder()

    let articleUrl = self.textField.text

    if (articleUrl != nil) {
      let parser = PageParser()
      parser.fetchArticleWithUrl(urlString: articleUrl!).continueWith { task in
        var html = task.result!
        html = "<head><style> P {font-size: 170%;font-family: Verdana, Arial, Helvetica, sans-serif}</style></head>".appending(html)
        
        self.webView.loadHTMLString(html, baseURL: nil)
      }
    }
  }
}

