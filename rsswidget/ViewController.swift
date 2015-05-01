//
//  ViewController.swift
//  rsswidget
//
//  Created by 王琪 on 15/4/26.
//  Copyright (c) 2015年 王琪. All rights reserved.
//

import UIKit
import PKHUD

class ViewController: UIViewController,UIWebViewDelegate {
    
    var webView:UIWebView?
    
    var newsUrl:String?
    
    override func viewDidLoad() {
        
        //var contentView = PKHUDProgressView()
        //PKHUD.sharedHUD.contentView = contentView
        
        
        self.webView = UIWebView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.webView?.delegate = self
        self.view.addSubview(self.webView!)
        
        if(newsUrl != nil){
            
            self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: newsUrl!)!))
            
        }
        
    }
    
    func reloadUrl(url:String){
        
        //PKHUD.sharedHUD.show()
        self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        
    }
    
    /*func webViewDidFinishLoad(webView: UIWebView) {
        
        PKHUD.sharedHUD.hide(animated: true)
        
    }*/
    
}