//
//  RSSParser.swift
//  Just
//
//  Created by Aleksey Goncharov on 31.01.17.
//  Copyright © 2017 Just. All rights reserved.
//

import Foundation

import BoltsSwift
import Alamofire
import AEXML

class RSSItem {
  var title: String = ""
  var link: String = ""
  var content: String = ""
}

class RSSFeed {
  var title: String = ""
  var link: String = ""
  var items: Array<RSSItem> = []
}

class RSSParser {
  
  
  func fetchFeed(urlString: String) -> Task<RSSFeed> {
    let completionSource = TaskCompletionSource<RSSFeed>()
    
    Alamofire.request(urlString).responseJSON { response in
      if let data = response.data {
        
        do {
          let docXML = try AEXMLDocument(xml: data, options: AEXMLOptions())
          let feedXML = docXML.children.first?.children.first;
          let feed = RSSFeed()
          for element in (feedXML?.children)! {
            if element.name == "title" {
              feed.title = element.value!
            } else if element.name == "link" {
              feed.link = element.value!
            } else if element.name == "item" {
              let rssItem = RSSItem()
              for itemElement in element.children {
                if itemElement.name == "title" {
                  rssItem.title = itemElement.value!
                } else if itemElement.name == "link" {
                  rssItem.link = itemElement.value!
                } else if itemElement.name == "content:encoded" {
                  rssItem.content = itemElement.value!.replacingOccurrences(of: "//hi-news.ru", with: "https://hi-news.ru")
                }
              }
              feed.items.append(rssItem)
            }
          }
          completionSource.trySet(result: feed)
        } catch {
          
        }
      }
    }
  
    return completionSource.task
  }
}
