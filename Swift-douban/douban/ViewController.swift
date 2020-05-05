//
//  ViewController.swift
//  Swift-豆瓣首页
//
//  Created by Tb on 2019/11/20.
//  Copyright © 2019 Tb. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON
import KakaJSON
import Toast_Swift
import Rswift

//let aa = R.reuseIdentifier.

class ViewController: UIViewController {
    
    let base_url = "https://douban-api.uieee.com/"
    var allMovies =
        [
            ["title" : "新片榜",
             "url" : "v2/movie/in_theaters",
             "movies" : []],
            ["title" : "口碑榜",
             "url" : "v2/movie/weekly",
             "movies" : []],
            ["title" : "北美票房榜",
             "url" : "v2/movie/us_box",
             "movies" : []],
            ["title" : "top250",
             "url" : "v2/movie/top250",
             "movies" : []]
    ]
    
    static let identifier = "movie";
    
    let movieTableView: UITableView = {
        let movieTableView = UITableView()
        //movieTableView.register(UINib(resource: R.nib.tableViewCell), forCellReuseIdentifier: identifier)
       movieTableView.register(type(of: TableViewCell()), forCellReuseIdentifier: identifier)
        return movieTableView
    }()
    
    let group = DispatchGroup()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieTableView.dataSource = self
        movieTableView.delegate = self
        self.view.addSubview(movieTableView)
        movieTableView.frame = self.view.bounds;
        
        
        self.navigationController?.view.makeToastActivity(.center)
        setupData(movieTypeIdx: 0)
        setupData(movieTypeIdx: 1)
        setupData(movieTypeIdx: 2)
        setupData(movieTypeIdx: 3)
        group.notify(queue: DispatchQueue.main) {
            self.navigationController?.view.hideToastActivity()
            self.movieTableView.reloadData()
        }
        
        if #available(iOS 11.0, *) {
            movieTableView.contentInsetAdjustmentBehavior = .always
        } else {
            automaticallyAdjustsScrollViewInsets = true
        }
        
        
    }
    
    
    private func setupData(movieTypeIdx idx: Int) -> Void {
        group.enter() // 加入组
        let url = allMovies[idx]["url"] as! String
        request(base_url + url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { [weak self] response in
            print(response)
            // 离开组
            self?.group.leave()
            
            switch response.result{
            case .success:
                guard let dict = response.result.value else {
                    return}
                
                var subjectArray = [[String : Any]]()
                
                if idx == 0 || idx == 3 {
                    subjectArray = JSON(dict)["subjects"].arrayObject as! [[String : Any]]
                } else {
                    guard let subjects = JSON(dict)["subjects"].arrayObject as? [[String : Any]] else {
                        return
                    }
                    
                    for subject in subjects {
                        if subject["subject"] != nil {
                            subjectArray.append(subject["subject"]! as! [String : Any])
                        }
                    }
                }
                
                let movie = modelArray(from: subjectArray, Movie.self)
                for m in movie {
                    if let obj = m.rating {
                        let intStars = Int(obj.stars)!
                        m.star?.on =  intStars / 10
                        m.star?.half = intStars % 10 > 0
                        m.star?.off = (50 - intStars) / 10
                    } else {
                        m.star = nil
                    }
                }
                
                self?.allMovies[idx]["movies"] = movie;
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.identifier) as! TableViewCell ;
        let moviesDict = self.allMovies[indexPath.section]
        
        if let movies = moviesDict["movies"] {
            cell.moveies = movies as! [Movie];
            cell.collectionView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = {
            let moreView = UIView()
            moreView.backgroundColor = UIColor.white
            let moveTypeLabel = UILabel()
            moveTypeLabel.font = UIFont.boldSystemFont(ofSize: 18)
            moveTypeLabel.textColor = UIColor.black
            moveTypeLabel.text = self.allMovies[section]["title"] as? String
            
            moreView.addSubview(moveTypeLabel)
            moveTypeLabel.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(20)
                make.centerY.equalToSuperview()
            }
            
            let moreButton = UIButton(type: .custom)
            moreButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            moreButton.setTitleColor(UIColor.black, for: .normal)
            moreButton.setTitle("查看更多 >", for:.normal)
            moreButton.addTarget(self, action:#selector(more) , for: .touchUpInside)
            moreView.addSubview(moreButton)
            moreButton.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-20)
                make.centerY.equalTo(moveTypeLabel)
            }
            return moreView
        }()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
}

extension ViewController {
    @objc func more() {
        print("more")
    }
}

extension ViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.allMovies.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250 + 24
    }
}


