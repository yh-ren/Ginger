//
//  ToDoItem.swift
//  Ginger
//
//  Created by Sabrina Ren on 2018-08-27.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    
    var title:String
    var completed:Bool
    var createdAt:Date
    var itemIdentifier:UUID // universally unique value used to identify each ToDoItem
    
    func saveItem() {
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
    func deleteItem() {
        DataManager.delete(itemIdentifier.uuidString)
    }
    
    mutating func markAsCompleted() {
        self.completed = true
        DataManager.save(self, with: itemIdentifier.uuidString)
    }
    
}
