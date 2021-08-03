//
//  Constants.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import Foundation

class Constants {
    static let BASE_URL = "https://hacker-news.firebaseio.com/v0/"
    static let GET_TOP_STORIES = BASE_URL + "topstories.json"
    static let GET_STORY_BY_ID = BASE_URL + "item/%d.json"
}
