//
//  TodayViewController.swift
//  Extension
//
//  Created by 王琪 on 15/4/26.
//  Copyright (c) 2015年 王琪. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NCWidgetProviding {
    var newsListTableView:UITableView?
    var newsList:Array<NewsItem>?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSizeMake(0, 263)
        self.newsListTableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        self.newsListTableView?.delegate = self
        self.newsListTableView?.dataSource = self
        self.view.addSubview(self.newsListTableView!)
        NewsItem.getNews
        {
            (newsList) in
            self.newsList = newsList
            let table:UITableView? = self.newsListTableView
            dispatch_async(dispatch_get_main_queue())
            {
                    table!.reloadData()
            }
        }
        // Do any additional setup after loading the view from its nib.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.newsList != nil){
            if(self.newsList!.count > 6)
            {	return 6	}
            else{	return self.newsList!.count	}}
        else{	return 0;}}
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {tableView.deselectRowAtIndexPath(indexPath, animated: false)
        var link=self.newsList![indexPath.row].link
        var urlString:NSString = NSString(format:"newsapp://?link=%@",link!.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        self.extensionContext?.openURL(NSURL(string: urlString as String )!, completionHandler: nil)}
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cellIdentifier:String = "cellIdentifier"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! UITableViewCell?
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel!.textColor = UIColor.lightGrayColor()
        cell?.textLabel!.text = self.newsList![indexPath.row].title!
        return cell!}
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {return UIEdgeInsetsZero}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
