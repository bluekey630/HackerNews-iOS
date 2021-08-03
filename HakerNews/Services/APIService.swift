//
//  APIService.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    private init() {
        
    }
    
    func getTopStories( completion: @escaping (Error?, Any?, Int?)->()) {

        let url = Constants.GET_TOP_STORIES

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                let status = response.response?.statusCode ?? 0
                completion(nil, data, status)
            case .failure(let error):
                completion(error, nil, 0)
            }
        }
    }
    
    func getStoryByID(id: Int, completion: @escaping (Error?, Any?, Int?)->()) {

        let url = String(format: Constants.GET_STORY_BY_ID, id)

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                let status = response.response?.statusCode ?? 0
                completion(nil, data, status)
            case .failure(let error):
                completion(error, nil, 0)
            }
        }
    }
}
