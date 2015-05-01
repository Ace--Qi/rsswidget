//
//  NewsItem.swift
//  rsswidget
//
//  Created by 王琪 on 15/4/26.
//  Copyright (c) 2015年 王琪. All rights reserved.
//

import Alamofire
import Foundation
class NewsItem {
    var title:String?
    var link:String?
    var pubDate:String?
    var description:String?

    init(title:String, link:String,pubDate:String,description:String)
    {
        self.title = title
        self.link = link
        self.pubDate = pubDate
        self.description = description

    }
    class func getNews(completionHandler: (Array<NewsItem>) -> Void) {
        var url:String = "http://feeds.bbci.co.uk/news/rss.xml"
        Alamofire.request(.GET, url).responseString { (_, _, string, err) in
        if(err != nil)
        {
            print(err?.debugDescription)
        }
        var error: NSError?
          if let xmlData:NSData = string?.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true){
            if let xmlDoc = AEXMLDocument(xmlData: xmlData, error: &error) {
            var resultNewsList:Array<NewsItem> = Array()
            for item in xmlDoc.root["channel"]["item"].all!{
              var newsTitle:String = item["title"].stringValue
              var newsLink:String = item["link"].stringValue
              var newsPubDate:String = item["pubDate"].stringValue
              var newsDescription:String = item["description"].stringValue

              var newsItem:NewsItem = NewsItem(title: newsTitle, link: newsLink, pubDate: newsPubDate, description: newsDescription)
                    resultNewsList.append(newsItem)
            }
               completionHandler(resultNewsList)
            }
          }
        }
    }
}
