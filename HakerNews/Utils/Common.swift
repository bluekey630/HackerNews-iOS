//
//  Common.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import Foundation
import UIKit

class Common {
    static let shared = Common()
    private init() {
        
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func convertDateToTimestamp(date: String) -> Int64 {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy hh:mm aa"
        let dt = df.date(from: date)
        let dateStamp = dt!.timeIntervalSince1970
        let dateSt = Int64(dateStamp)
        return dateSt
    }
//
    func convertTimestampToDate(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()

        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)

        return strDate
    }
    
    func convertTimestampToGeneralDate(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()

        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEEE, dd MMMM" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)

        return strDate
    }
    
    func convertTimestampToTime(timestamp: Int64) -> String {
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()

        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "h:mm aa" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)

        return strDate
    }
    
    func getTimeStringFromTimestamp(timestamp: Int64) -> String{
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let dateFormatter = DateFormatter()

        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)

        print(strDate)
        return strDate
    }
    
    func getGeneralTimeString(timestamp: Int64) -> String {
        let offset = Int64(Date().timeIntervalSince1970) - timestamp
        let hr = (offset) / 3600
        let min = ((offset) % 3600) / 60
        let day = hr / 24
        
        var str = ""
        if hr < 1 {
            str = "\(min) minutes ago"
        } else if hr < 48 {
            str = "\(hr) hours ago"
        } else {
            str = "\(day) days ago"
        }

        return str
    }
}

