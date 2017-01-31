//
//  FeedViewController.swift
//  Just
//
//  Created by Aleksey Goncharov on 01.02.17.
//  Copyright © 2017 Just. All rights reserved.
//

import UIKit

class FeeedViewController: UITableViewController {
  var rssFeed: RSSFeed? = nil
  
  
  override func viewDidLoad() {
    let rss = "http://www.theverge.com/rss/frontpage" //"https://hi-news.ru/feed"
    let parser = RSSParser()
    parser.fetchFeed(urlString: rss).continueWith { task in
      if let result = task.result {
        self.rssFeed = result
        self.tableView.reloadData()
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let feed = self.rssFeed {
      return feed.items.count
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = self.rssFeed?.items[indexPath.row]
    
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = item?.title
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let item = self.rssFeed?.items[indexPath.row]
    
    self.performSegue(withIdentifier: "showPage", sender: item)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let webController = segue.destination as! ViewController
    webController.item = sender as? RSSItem
  }
}
