
//
//  File.swift
//  Ciwa
//
//  Created by marouane lanouari on 15/11/2018.
//  Copyright © 2018 marouane. All rights reserved.
//

import Foundation
import Moya
import RxSwift


private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let GuildWarsProvider = MoyaProvider<GuildWarsApi>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

public enum GuildWarsApi {
    case groupsId
    case groups(Array<String>)
    case categories(Array<Int>)
    case achievements(Array<Int>)
    case achievement(Int)
}

extension GuildWarsApi: TargetType {
    
    public var baseURL: URL { return URL(string: "https://api.guildwars2.com/v2")! }
    public var path: String {
        switch self {
        case .groupsId:
            return "/achievements/groups"
        case .groups:
            return "/achievements/groups"
        case .categories:
            return "achievements/categories"
        case .achievements:
            return "/achievements"
        case .achievement(let id):
            return "/achievements/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .groupsId, .achievement, .categories, .achievements, .groups:
                return .get
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .groups(let ids):
            return ["ids": (ids as NSArray).componentsJoined(by: ",").removingPercentEncoding ?? ""]
        case .categories(let ids):
            return ["ids": (ids as NSArray).componentsJoined(by: ",").removingPercentEncoding ?? ""]
        case .achievements(let ids):
            return ["ids": (ids as NSArray).componentsJoined(by: ",").removingPercentEncoding ?? ""]
        default:
            return nil
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
            return URLEncoding.queryString
    }
    public var task: Task {
        guard let params = parameters else { return .requestPlain }
        return .requestParameters(parameters: params, encoding: parameterEncoding)
    }
    public var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    public var sampleData: Data {
        return Data()
    }
    public func url(_ route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }
}
