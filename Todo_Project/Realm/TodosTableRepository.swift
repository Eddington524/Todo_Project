//
//  TodosTableRepository.swift
//  Todo_Project
//
//  Created by Sammy Jung on 2/17/24.
//

import Foundation
import RealmSwift

final class TodosTableRepository {
    
    private let realm = try! Realm()
    
    let model = Todotable.self
    
    func createItem(_ item: Todotable) {
        
        do {
            try realm.write {
                realm.add(item)
                print("realm create")
            }
        } catch {
            print(error)
        }
    }
    
    func fetch() -> Results<Todotable> {
        return realm.objects(model)
    }
    
    func fetchFilter(_ type: sortType) -> Results<Todotable> {
//        realm.objects(Todotable.self).where{
//            $0.
//        }
        if type == .prioritySort {
            realm.objects(model).where{
                $0.priority == 0
            }.sorted(byKeyPath: type.rawValue)
            
        }else{
             realm.objects(model).sorted(byKeyPath: type.rawValue, ascending: true)
        }
    }
    
    func fetchTodayCount() -> Results<Todotable> {
        
        let calender = Calendar.current
        let start = calender.startOfDay(for: Date())
        let end = calender.date(byAdding: .day, value: 1, to: start)
        
        let list = realm.objects(model).where{
            $0.duedate >= start && $0.duedate < end!
        }
        return list
    }
    
//    func fetchUpcommingCount() -> Results<Todotable> {
//        
//        let calender = Calendar.current
//        let start = calender.startOfDay(for: Date())
//        let end = calender.date(byAdding: .day, value: 1, to: start)
//        
//        let list = realm.objects(model).where{
//            $0.duedate >= start && $0.duedate < end!
//        }
//        return list
//    }
}
