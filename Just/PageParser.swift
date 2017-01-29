//
//  PageParser.swift
//  Just
//
//  Created by Aleksey Goncharov on 29.01.17.
//  Copyright © 2017 Just. All rights reserved.
//

import UIKit

import BoltsSwift
import Alamofire
import JASON

class PageParser: NSObject {

  var completionSource = TaskCompletionSource<String>()
  
  func fetchArticleWithUrl(urlString: String) -> Task<String> {
    let parameters: Parameters = ["url" : urlString]
    let headers: HTTPHeaders = ["x-api-key" : "CHntIUEWQvtPQK7MTOMX8SdMAZtsFcM17HgUxsFQ"]
    
    Alamofire.request("https://mercury.postlight.com/parser",
                      parameters: parameters,
                      headers: headers).responseJSON { response in
                        let json = JSON(response.value)
                        let content = json["content"].stringValue
                        self.completionSource.trySet(result: content)
    }
    return completionSource.task
  }
}
