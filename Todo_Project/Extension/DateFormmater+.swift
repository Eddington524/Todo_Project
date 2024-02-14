//
//  DateFormmater+.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import Foundation

extension DateFormatter {
    static func convertDate(_ date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss +0000"
        guard let rawDate = formatter.date(from: date) else { return "ERROR" }
        formatter.dateFormat = "yyyy년 MM월 dd일"
        return formatter.string(from: rawDate)
    }
}
