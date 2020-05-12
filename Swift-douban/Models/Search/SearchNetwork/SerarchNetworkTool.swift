//
//  TableViewCell.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/12.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import Moya
import KakaJSON


class SerarchNetworkTool: NSObject {
    static let shared = SerarchNetworkTool()
    
    let provider = MoyaProvider<TrendingGithubAPI>()

    func requestTrendUserRepoData(language: String, since: String,  completion: @escaping ([TrendUser]) -> ()){
    
    provider.request(.trendingDevelopers(language: "", since: since)) { result in
        switch result {
        case .success(let response):
            print(try? response.mapJSON() ?? "" )
            if response.statusCode == 200 {
                guard let josnArray = try? response.mapJSON() as? [[String: Any]] else {return}
                let dataModels = modelArray(from: josnArray, TrendUser.self)
                completion(dataModels)
            }
        case .failure(let anError):
            print("error:\(anError.errorDescription!)")
            break
            
        }
       }
    }
        
        
  func requestTrendRepositoryData(language: String, since: String, periodValue: String,  completion: @escaping ([TrendReposity]) -> ()){
  
  provider.request(.trendingRepositories(language: "", since: since)) { result in
      switch result {
      case .success(let response):
          //print(try? response.mapJSON() ?? "" )
          if response.statusCode == 200 {
              guard let josnArray = try? response.mapJSON() as? [[String: Any]] else {return}
              let dataModels = modelArray(from: josnArray, TrendReposity.self)
              dataModels.map{$0.trendingPeriod = periodValue}
              completion(dataModels)
          }
      case .failure(let anError):
          print("error:\(anError.errorDescription!)")
          break
          
      }
    }
  }
    
}

//    func requestData(_ searchType :SearchTypeSegments) -> BaseReposity {
//        let provider = MoyaProvider<TrendingGithubAPI>()
//        provider.request(searchType ==  .repositories ? .trendingRepositories(language: "", since: self.trendingPeriod.paramValue) : .trendingDevelopers(language: "", since: self.trendingPeriod.paramValue)) { [weak self] result in
//            switch result {
//            case .success(let response):
//                print(try? response.mapJSON() ?? "" )
//                if response.statusCode == 200 {
//                    guard let josnArray = try? response.mapJSON() as? [[String: Any]] else {return}
//                    self?.dataModels = modelArray(from: josnArray, TrendReposity.self)
//
//                    self?.dataModels.map{$0.trendingPeriod = self?.trendingPeriod.titleValue}
//                    self?.tableView.reloadData()
//                }
//            case .failure(let anError):
//                print("error:\(anError.errorDescription!)")
//                break
//
//            }
//        }
//    }
//}
//
//st :  {
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//
//    func requestData(_ searchType :SearchTypeSegments){
//        let provider = MoyaProvider<TrendingGithubAPI>()
//        provider.request(searchType ==  .repositories ? .trendingRepositories(language: "", since: self.trendingPeriod.paramValue) : .trendingDevelopers(language: "", since: self.trendingPeriod.paramValue)) { [weak self] result in
//            switch result {
//            case .success(let response):
//                print(try? response.mapJSON() ?? "" )
//                if response.statusCode == 200 {
//                    guard let josnArray = try? response.mapJSON() as? [[String: Any]] else {return}
//                    self?.dataModels = modelArray(from: josnArray, TrendReposity.self)
//
//                    self?.dataModels.map{$0.trendingPeriod = self?.trendingPeriod.titleValue}
//                    self?.tableView.reloadData()
//                }
//            case .failure(let anError):
//                print("error:\(anError.errorDescription!)")
//                break
//
//            }
//        }
//    }
//
//}
