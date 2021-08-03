//
//  PostModel.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import Foundation

class PostModel : NSObject {
    
    var id = 0
    var by = ""
    var descendants = 0
    var kids: [Int] = []
    var score = 0
    var time: Int64 = 0
    var title = ""
    var type = ""
    var url = ""
    
    override init() {
        super.init()
    }
    
    init(dict: [String: Any]) {
        if let val = dict["id"] as? Int                 { id = val }
        if let val = dict["by"] as? String              { by = val }
        if let val = dict["descendants"] as? Int        { descendants = val }
        if let val = dict["kids"] as? [Int]             { kids = val }
        if let val = dict["score"] as? Int              { score = val }
        if let val = dict["time"] as? Int64             { time = val }
        if let val = dict["title"] as? String           { title = val }
        if let val = dict["type"] as? String            { type = val }
        if let val = dict["url"] as? String             { url = val }
    }
}
