//
//  SearchTableViewController.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/5.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import Rswift
import HMSegmentedControl
import DropDown
import Moya

typealias DropDownView = DropDown

//enum NetWorkError: MoyaError {
//    typealias RawValue = <#type#>
//
//
//    case anError
//}

enum SearchTypeSegments: Int {
    case repositories, users

    var title: String {
        switch self {
        case .repositories: return "存储库"
        case .users: return "用户"
        }
    }
}

enum TrendingPeriodSegments: Int {
    case daily, weekly, montly

    var title: String {
        switch self {
        case .daily: return "每日"
        case .weekly: return "每周"
        case .montly: return "每月"
        }
    }

    var paramValue: String {
        switch self {
        case .daily: return "daily"
        case .weekly: return "weekly"
        case .montly: return "monthly"
        }
    }
}

enum SearchModeSegments: Int {
    case trending, search

    var title: String {
        switch self {
        case .trending: return "趋势"
        case .search: return "搜索"
        }
    }
}

enum SortRepositoryItems: Int {
    case bestMatch, mostStars, fewestStars, mostForks, fewestForks, recentlyUpdated, lastRecentlyUpdated

    var title: String {
        switch self {
        case .bestMatch: return "最佳匹配"
        case .mostStars: return "最多星星"
        case .fewestStars: return "最少星星"
        case .mostForks: return "复制分支最多"
        case .fewestForks: return "复制分支最少"
        case .recentlyUpdated: return "最近更新"
        case .lastRecentlyUpdated: return "最近更新"
        }
    }

    var sortValue: String {
        switch self {
        case .bestMatch: return ""
        case .mostStars, .fewestStars: return "stars"
        case .mostForks, .fewestForks: return "forks"
        case .recentlyUpdated, .lastRecentlyUpdated: return "updated"
        }
    }

    var orderValue: String {
        switch self {
        case .bestMatch: return ""
        case .mostStars, .mostForks, .recentlyUpdated: return "desc"
        case .fewestStars, .fewestForks, .lastRecentlyUpdated: return "asc"
        }
    }

    static func allItems() -> [String] {
        return (0...SortRepositoryItems.lastRecentlyUpdated.rawValue)
            .map { SortRepositoryItems(rawValue: $0)!.title }
    }
}


class SearchTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    lazy var tableView: TableView = {
           let view = TableView(frame: CGRect(), style: .plain)
           view.dataSource = self
           view.delegate = self
           view.register(type(of: UITableViewCell()), forCellReuseIdentifier: "reuseIdentifier")
//           view.emptyDataSetSource = self
//           view.emptyDataSetDelegate = self
           //view.rx.setDelegate(self).disposed(by: rx.disposeBag)
           return view
       }()
    
    lazy var rightButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: R.image.icon_navigation_language(), style: .done, target: nil, action: nil)
        return view
    }()
    
    lazy var segmentedControl: SegmentedControl = {
        let images = [
            R.image.icon_cell_badge_repository()!.tint(UIColor.Material.grey900, blendMode: .normal).withRoundedCorners()!,
            R.image.icon_cell_badge_user()!.tint(UIColor.Material.grey900, blendMode: .normal).withRoundedCorners()!
        ]
        let selectedImages = [
            R.image.icon_cell_badge_repository()!.tint(UIColor.Material.red, blendMode: .normal).withRoundedCorners()!,
            R.image.icon_cell_badge_user()!.tint(UIColor.Material.red, blendMode: .normal).withRoundedCorners()!
        ]
        let view = SegmentedControl(sectionImages: images, sectionSelectedImages: selectedImages)
        view?.selectedSegmentIndex = 0
        view?.snp.makeConstraints({ (make) in
            make.width.equalTo(200)
        })
        view?.didSelectItem = { idx in
            print(idx)
        }
        return view!
    }()
    
    let trendingPeriodView = View()
       lazy var trendingPeriodSegmentedControl: SegmentedControl = {
           let items = [TrendingPeriodSegments.daily.title, TrendingPeriodSegments.weekly.title, TrendingPeriodSegments.montly.title]
           let view = SegmentedControl(sectionTitles: items)
           view.selectedSegmentIndex = 0
           return view
       }()
    
       let searchModeView = View()
       lazy var searchModeSegmentedControl: SegmentedControl = {
           let items = [SearchModeSegments.trending.title, SearchModeSegments.search.title]
           let view = SegmentedControl(sectionTitles: items)
           view.selectedSegmentIndex = 0
           return view
       }()
    
    lazy var totalCountLabel: Label = {
        let view = Label()
        view.font = view.font.withSize(14)
        view.text = "11111"
        view.leftTextInset = self.inset
        return view
    }()
    
    lazy var labelsStackView: StackView = {
        let view = StackView(arrangedSubviews: [self.totalCountLabel, self.sortLabel])
        view.axis = .horizontal
        return view
    }()

    lazy var sortDropDown: DropDownView = {
        let view = DropDownView(anchorView: self.tableView)
        return view
    }()

    lazy var sortLabel: Label = {
        let view = Label()
        view.font = view.font.withSize(34)
        view.text = "11111"
        view.textAlignment = .right
        view.rightTextInset = self.inset
        return view
    }()
    
    lazy var searchBar: SearchBar = {
        let view = SearchBar()
        return view
    }()
    
    lazy var contentView: View = {
        let view = View()
        //        view.hero.id = "CententView"
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        return view
    }()
    
    lazy var stackView: StackView = {
           let subviews: [UIView] = []
        
           let view = StackView(arrangedSubviews: subviews)
           view.spacing = 0
           self.contentView.addSubview(view)
           view.snp.makeConstraints({ (make) in
               make.edges.equalToSuperview()
           })
           return view
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Material.grey200
        
        stackView.spacing = 0
        stackView.insertArrangedSubview(tableView, at: 0)
  
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.titleView = segmentedControl
        
        trendingPeriodView.addSubview(trendingPeriodSegmentedControl)
        trendingPeriodSegmentedControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(self.inset)
        }


        searchModeView.addSubview(searchModeSegmentedControl)
        searchModeView.isHidden = true
        searchModeSegmentedControl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(self.inset)
        }

        labelsStackView.isHidden = true
        stackView.insertArrangedSubview(labelsStackView, at: 0)
        stackView.insertArrangedSubview(trendingPeriodView, at: 0)
        stackView.insertArrangedSubview(searchBar, at: 0)
        stackView.addArrangedSubview(searchModeView)

        labelsStackView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        let provider = MoyaProvider<TrendingGithubAPI>()
        provider.request(.trendingRepositories(language: "java", since: "")) { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                   let json = try? response.mapJSON()
                    print(json ?? "")
                }
            case .failure(let anError):
                print("error:\(anError.errorDescription!)")
                break
                
            }
        }
        
    }
    
    @objc func goLanuage(){
        print("goLanuage")
    }

    // MARK: - Table view data source

//     func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "111"
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchTableViewController {
    var inset: CGFloat {
           return Configs.BaseDimensions.inset
       }
}
