//
//  Moemo.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Foundation

public struct Memo {
    let id: UUID = UUID()
    var title: String
    var content: String
    var createdAt: Date = Date()
    var editedAt: Date = Date()
    var lastReadAt: Date = Date()
    var liked: Bool = false
    
    mutating func edit(title: String?, content: String?) {
        if let title = title {
            self.title = title
        }
        if let content = content {
            self.content = content
        }
        self.editedAt = Date()
    }
    
    mutating func read() {
        self.lastReadAt = Date()
    }
    
    mutating func toggleLike() -> Bool {
        self.liked.toggle()
        return liked
    }
}
