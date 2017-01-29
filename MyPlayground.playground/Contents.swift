//: Playground - noun: a place where people can play

import UIKit
import WebKit

let fileUrl = URL(fileURLWithPath: "file:///Users/agoncharov/Documents/post.html")
let str = "<article><p>some backslashed symbols</p></article>"
let s = str as NSString
print(str)

let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

let request = URLRequest(url: URL(string: "https://yandex.ru")!)
webView.loadRequest(request)





