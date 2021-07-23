//
//  APIManager.swift
//  Farsight App
//
//  Created by WebDEV on 7/21/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

enum NetworkEnvironment {
    case dev
    case production
}

class APIManager {
    
    // MARK: - Vars & Lets
    
    static let networkEnviroment: NetworkEnvironment = .dev
    
    // MARK: - Vars & Lets
    
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager()
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
    
    // MARK: - Initialization
    
    private init() {
    }

    
    func call<T: Codable>(type: EndPointType, params: Parameters? = nil, progress: Bool = false, handler: @escaping (T?, Error?)->()) {
        
        if progress {
            self.showLoader()
        }

        AF.request(type.url, method: type.httpMethod, parameters: params, encoding: type.encoding, headers: type.headers).validate().responseDecodable(of: T.self) { (response) in
            if progress {
                self.hideLoader()
            }
            switch response.result {
            case .success(let value):
                handler(value, nil)
                break
                
            case .failure(let error):
                print(error)
                handler(nil ,NSError() as Error)
                break
            }
        }
    }
    
    func uploadPhoto(type: EndPointType, params: Parameters, handler: @escaping (JSON?, JSON?)->()) {
        print("\(type.baseURL) \(type.httpMethod) \(type.url) \(type.encoding) \(type.headers)")
        AF.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in params {
                multipartFormData.append((value as! String).data(using: .utf8, allowLossyConversion: false)!, withName: key)
            }
            print(multipartFormData)
        },to: type.url,
        usingThreshold: UInt64.init(),
        method: type.httpMethod,
        headers: type.headers).response{ response in
            print(response.response?.statusCode)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                handler(json, nil)
                break
                
            case .failure(let error):
                
                handler(nil , JSON(error))
                break
            }
        }
    }
    
    func uploadPhoto(type: EndPointType, multipart: MultipartFormData, handler: @escaping (JSON?, JSON?)->()) {
        print("\(type.baseURL) \(type.httpMethod) \(type.url) \(type.encoding) \(type.headers)")
        
        AF.upload(multipartFormData: multipart,to: type.url,
                  usingThreshold: UInt64.init(),
                  method: type.httpMethod,
                  headers: type.headers).response{ response in
                    print(response.response?.statusCode)
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        handler(json, nil)
                        break
                        
                    case .failure(let error):
                        
                        handler(nil , JSON(error))
                        break
                    }
                  }
    }
    
    func showLoader() {
//        SVProgressHUD.setDefaultStyle(.custom)
//        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setForegroundColor(UIColor.darkGray)           //Ring Color
        SVProgressHUD.setBackgroundColor(UIColor.gray)        //HUD Color
        SVProgressHUD.setBackgroundLayerColor(UIColor.lightGray)    //Background Color
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
}
