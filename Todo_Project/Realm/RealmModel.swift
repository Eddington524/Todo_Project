//
//  RealmModel.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/15/24.
//

import Foundation
import RealmSwift

class Todotable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var duedate: Date
    @Persisted var tag: String
    @Persisted var priority: Int
 
    convenience init(title: String, memo: String? = nil, duedate: Date, tag: String, priority: Int) {
        self.init()
        self.title = title
        self.memo = memo
        self.duedate = duedate
        self.tag = tag
        self.priority = priority
    }
}
