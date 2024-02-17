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
        return realm.objects(Todotable.self)
    }
    
    func fetchFilter(_ type: sortType) -> Results<Todotable> {
//        realm.objects(Todotable.self).where{
//            $0.
//        }
        
        if type == .prioritySort {
            realm.objects(Todotable.self).where{
                $0.priority == 0
            }.sorted(byKeyPath: type.rawValue)
            
        }else{
             realm.objects(Todotable.self).sorted(byKeyPath: type.rawValue, ascending: true)
        }
    }
}
