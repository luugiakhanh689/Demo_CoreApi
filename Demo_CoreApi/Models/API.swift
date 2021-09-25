//
//  API.swift
//  Demo_CoreApi
//
//  Created by Khánh Vỹ Đinh on 14/06/2021.
//

import Foundation
typealias APICompletion<T> = (Result<T,ErrorApi>)->()
typealias JSON = [String:Any]
enum ErrorApi:Error {
    case UrlError
    case Error(String)
    func localDescription() -> String {
        switch self{
        case .UrlError: return "URL Errror"
        case .Error(let error):return error
        }
    }
}
enum ApiResult {
    case failure(ErrorApi)
    case success(Data?)
}
struct API {
    private init(){
        
    }
    private static let shareApi:API={
        let api=API()
        return api
    }()
    static func share()->API{
        return shareApi
    }
}
extension API{
    func request(urlString:String,completion:@escaping (ApiResult)->())  {
        guard let url=URL(string: urlString) else {
            completion(.failure(.UrlError))
            return
        }
        let config=URLSessionConfiguration.ephemeral
        config.waitsForConnectivity=true
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: url, completionHandler: {
            data,res,error in
            if error != nil{
                completion(.failure(.UrlError))
            }
            else{
                completion(.success(data))
            }
        })
        task.resume()
    }
    func request(url:URL,completion:@escaping (ApiResult)->())  {
        let config=URLSessionConfiguration.ephemeral
        config.waitsForConnectivity=true
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: url, completionHandler: {
            data,res,error in
            if error != nil {
                completion(.failure(.UrlError))
            }
            else{
                completion(.success(data))
            }
        })
        task.resume()
    }
    func request(request:URLRequest,completion:@escaping (ApiResult)->())  {
        let config=URLSessionConfiguration.ephemeral
        config.waitsForConnectivity=true
        let session=URLSession(configuration: config)
        let task=session.dataTask(with: request, completionHandler: {
            data,res,error in
            if error != nil {
                completion(.failure(.UrlError))
            }
            else{
                completion(.success(data))
            }
        })
        task.resume()
    }
}
