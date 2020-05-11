//
//  GithubApi.swift
//  moyaDemo
//
//  Created by Tb on 2020/5/9.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import Moya
import Rswift


enum TrendingGithubAPI {
    case trendingRepositories(language: String, since: String)
    case trendingDevelopers(language: String, since: String)
    case languages
}

extension TrendingGithubAPI: TargetType {
    
    var baseURL: URL {
       return  URL(string:"https://github-trending-api.now.sh")!
    }
    
    var path: String {
        switch self {
        case .trendingRepositories: return "/repositories"
        case .trendingDevelopers: return "/developers"
        case .languages: return "/languages"
       }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
        
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case .trendingRepositories(let language, let since),
             .trendingDevelopers(let language, let since):
        params["language"] = language
        params["since"] = since
        default: break
        }
        return params
    }
    
    var sampleData: Data {
         var dataUrl: URL?
               switch self {
//               case .trendingRepositories: dataUrl = R.file.repositoryTrendingsJson()
//               case .trendingDevelopers: dataUrl = R.file.userTrendingsJson()
//               case .languages: dataUrl = R.file.languagesJson()
                
               case .trendingRepositories(language: let language, since: let since):
                     dataUrl = baseURL
               case .trendingDevelopers(language: let language, since: let since):
                 dataUrl = baseURL
               case .languages:
                 dataUrl = baseURL
              }
               if let url = dataUrl, let data = try? Data(contentsOf: url) {
                   return data
               }
               return Data()
    }
    
     var parameterEncoding: ParameterEncoding {
           return URLEncoding.default
      }
        
    var task: Task {
        if let parameters = parameters {
            return .requestParameters(parameters: parameters, encoding: parameterEncoding)
        }
        return .requestPlain
    }

    
    var headers: [String : String]? {
        return nil
    }
    
    
}
