//
//  String+Date.swift
//  iGithub
//
//  Created by yfm on 2019/1/7.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation

extension String {
    func toDate(dateFormat: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh")
        formatter.dateFormat = dateFormat
        let toDate = formatter.date(from: self)
        return toDate
    }

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data.init(self.utf8).base64EncodedString()
    }

    public func isEmail() -> Bool {
        let pattern = "\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
        return self.range(of: pattern,
                          options: String.CompareOptions.regularExpression,
                          range: nil,
                          locale: nil) != nil
    }
    
    /// 资讯类时间戳转字符串
    ///
    /// - Parameter timeStamp: 时间戳
    /// - Returns: 转换之后的字符串
    static func timeStampToString(timeStamp: TimeInterval) -> String {
        let date = Date(timeIntervalSince1970: timeStamp)
    
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh")
        formatter.dateFormat = "HH:mm"
        let dateFormat1 = formatter.string(from: date)
        formatter.dateFormat = "y 年 M 月 d日 HH:mm"
        let dateFormat2 = formatter.string(from: date)
        formatter.dateFormat = "M 月 d 日"
        let dateFormat3 = formatter.string(from: date)

        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: date, to: now)

        if calendar.isDateInToday(date) { // 今天
            return "今天 " + dateFormat1
        } else if calendar.isDateInYesterday(date) { // 昨天
            return "昨天 " + dateFormat1
        } else if components.year! == 0 { // 今年
            return dateFormat3
        } else { // 往年
            return dateFormat2
        }
    }
}
