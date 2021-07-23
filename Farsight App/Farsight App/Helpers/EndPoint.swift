//
//  EndPoint.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import Foundation
import Alamofire

protocol EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
    
}

enum EndpointItem {
    
    // MARK: - User actions
    
    case getWorkOrderList
    case getWorkOrderDetail(_: String)
    case updateWorkOrderDetail(_: String)
    case getWorkOrderPhotos(_: String)
    case uploadPhoto(_: String)
}

// MARK: - Extensions
// MARK: - EndPointType
extension EndpointItem: EndPointType {
    
    // MARK: - Vars & Lets
    
    var baseURL: String {
        switch APIManager.networkEnviroment {
        case .dev: return Config.baseURL
        case .production: return Config.baseURL
        }
    }
    
    var version: String {
        return "/v0_1"
    }
    
    var path: String {
        switch self {
        case .getWorkOrderList:
            return "/api/work_order/list"
        case .getWorkOrderDetail(let id):
            return "/api/work_order/\(id)"
        case .updateWorkOrderDetail(let id):
            return "/api/work_order/\(id)"
        case .getWorkOrderPhotos(let id):
            return "/api/work_order/\(id)/photo"
        case .uploadPhoto(let id):
            return "/api/work_order/\(id)/photo"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .updateWorkOrderDetail(_),.uploadPhoto(_):
            return .post
        default:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        default:
            return [
                "X-USER-ID": Config.userId,
                "X-APP-ID": Config.appId
            ]
        }
    }
    
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }
    
}
