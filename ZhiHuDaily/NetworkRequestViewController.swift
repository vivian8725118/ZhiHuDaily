//
//  NetworkRequestViewController.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/8.
//  Copyright © 2017年 vivian. All rights reserved.
//

import UIKit
import MJRefresh
import Kingfisher
import Alamofire
import ObjectMapper

class NetworkRequestViewController:UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView: UITableView!
    var datas: [Article] = []
    var days : Int = 0
    var date : String = ""
    var url_string : String = ""//url
    var width : CGFloat = 0
    var height : CGFloat = 0

    //下拉刷新
    var header = MJRefreshNormalHeader()
    //上拉加载
    var footer = MJRefreshAutoNormalFooter()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor =
//            UIColor(red: 249/255, green: 92/255, blue: 85/255, alpha: 0.3)

            UIColor(red: 250/255, green: 106/255, blue: 99/255, alpha: 0.1)
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //监测横竖屏切换
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        self.navigationItem.title = "最新文章"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(WebViewController.back))
        
        loadMore(isRefresh: true)
        
       
        initViewPager()
        initTableView()
         initFirstPage()
    }
    
    func initFirstPage(){
        let imageview = UIImageView( frame: CGRect( x: 0, y: 0, width: self.width, height: self.height))
        let url = URL(string: "http://news-at.zhihu.com/api/4/start-image/1080*1776")
//         let url = URL(string: "http://p4.zhimg.com/7b/c8/7bc8ef5947b069513c51e4b9521b5c82.jpg")
        imageview.kf.setImage(with: url)
        self.view.addSubview(imageview)
    }
    
    //监测方向变化
    func didChangeOrientation() {
        if (UIDevice.current.orientation == .portrait) {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.transform = .identity
                self.view.bounds = CGRect(x: 0, y: 0, width: self.width, height: self.height)
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.transform = .identity
                self.view.bounds = CGRect(x: 0, y: 0, width: self.height, height: self.width)
                self.tableView.frame = CGRect(x: 0, y: 0, width: self.height, height: self.width)
            })
        }
    }
    
    //下拉刷新，加载更多
    func loadMore(isRefresh: Bool){
        if(isRefresh){
            days = 0
            self.datas = []
            url_string = "https://news-at.zhihu.com/api/4/news/latest"
        }else {
            url_string = "http://news-at.zhihu.com/api/4/news/before/" + date
        }
        
        Alamofire.request(url_string,method: .get).responseString{
            response in
            
            if let JSON = response.result.value {
                //                print("JSON: \(JSON)")
                let resultData = Mapper<BaseModel>().map(JSONString: JSON)
//                self.datas = (resultData?.stories)!
                self.datas = self.datas + (resultData?.stories)!
                self.tableView.reloadData()
                self.days = self.days + 1
                if(isRefresh){
                    self.tableView.mj_header.endRefreshing()
                }else{
                    self.tableView.mj_footer.endRefreshing()
                }
                self.date = (resultData?.date)!
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id: Int = datas[indexPath.row].id
        let webViewController  = ArticleDetailViewController()
        webViewController.setId(id: id)
        self.navigationController?.pushViewController(webViewController, animated: true)
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.selectionStyle = (UITableViewCellSelectionStyle.none);
        tableView.deselectRow(at: indexPath, animated: true);
    }
    
    func initViewPager(){
//        let pagerView = FSPagerView(frame: self.frame)
//        pagerView.dataSource = self
//        pagerView.delegate = self
//        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
//        self.view.addSubview(pagerView)
//        
//        let pagerControl = FSPagerControl(frame:self.frame)
//        self.view.addSubview(pageControl)
    }
    
    //初始化tableview
    func initTableView(){
        // 创建tableView
        if(UIDevice.current.orientation == UIDeviceOrientation.portrait){
           tableView = UITableView(frame: CGRect(origin:CGPoint(x:0, y:0), size:CGSize(width:self.view.frame.size.width, height:self.view.frame.size.height)), style: UITableViewStyle.plain)
            self.width = UIScreen.main.bounds.width
            self.height = UIScreen.main.bounds.height
        }else{
           tableView = UITableView(frame: CGRect(origin:CGPoint(x:0, y:0), size:CGSize(width:self.view.frame.size.height, height:self.view.frame.size.width)), style: UITableViewStyle.plain)
            self.width = UIScreen.main.bounds.height
            self.height = UIScreen.main.bounds.width
        }
//
        //注册Cell
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(UINib(nibName: "ArticleTableViewCell",bundle: nil), forCellReuseIdentifier: "Cell")
        
        //设置数据源和代理
        tableView.dataSource=self
        tableView.delegate=self
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        //添加到view中
        self.view.addSubview(tableView)
        
        //设置普通下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        //隐藏最后一次更新时间
        header.lastUpdatedTimeLabel.isHidden = true
        //自定义各种状态下的文字
        header.setTitle("下拉刷新数据", for: .idle)
        header.setTitle("松开刷新数据", for: .pulling)
        header.setTitle("正在刷新数据", for: .refreshing)
        self.tableView.mj_header = header
        
        //设置普通上拉加载
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        //自定义各种状态下的文字
        footer.setTitle("点击或上拉加载更多", for: .idle)
        footer.setTitle("松开加载数据", for: .pulling)
        footer.setTitle("正在加载数据", for: .refreshing)
        footer.setTitle("已全部加载完！", for: .noMoreData)
        self.tableView.mj_footer = footer
    }
    
    //下拉更新操作
    func headerRefresh() {
        loadMore(isRefresh: true)
    }
    //点击或上拉加载操作
    func footerRefresh() {
         loadMore(isRefresh: false)
    }
    
    //return count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    //return cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel!.text=datas[indexPath.row].title?.trimmingCharacters(in: .whitespacesAndNewlines)
//        let url = URL(string:"https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-6.jpg")
////        let url = URL(string: (datas[indexPath.row].images?[0])!)
//        cell.imageView?.kf.setImage(with: url)
     
//        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ArticleTableViewCell
        
        
        let cell: ArticleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ArticleTableViewCell
        
        cell.myTextLabel!.text=datas[indexPath.row].title?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let url = URL(string: (datas[indexPath.row].images?[0])!)
//       let url = URL(string: "http://pic1.zhimg.com/44b4830451176478cc96ea79f5519884.jpg")

        cell.myImageView?.kf.setImage(with: url)
        cell.myImageView?.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
            print("received:%d", receivedSize / totalSize)
        }, completionHandler: { (image, error, cacheType, url) in
            if(error != nil){
                print(error ?? "")
            }
            print(url ?? "")
        })
        
        return cell
    }

    
    //在本例中，只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //单元格高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}
