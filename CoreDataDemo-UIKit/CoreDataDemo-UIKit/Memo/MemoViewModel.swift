//
//  MemoViewModel.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Combine
import Foundation

struct Memo {
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

protocol MemoModelProtocol {
    
    func addMemo(title: String, content: String)
    
    func editMemo(id: UUID, title: String?, content: String?)
    
    func deleteMemo(id: UUID)
    
    func fetchMemos() -> [Memo]
    
    func toggleLike(id: UUID)
    
    func searchMemos(keyword: String) -> [Memo]
}

class MemoViewModel: ObservableObject, MemoModelProtocol {
    
    @Published var list: [Memo] = []
    
    func addMemo(title: String, content: String) {
        list.append(Memo(title: title, content: content))
    }
    
    func editMemo(id: UUID, title: String?, content: String?) {
        guard let index = list.firstIndex(where: {$0.id == id}) else {
            return
        }
        list[index].edit(title: title, content: content)
    }
    
    func deleteMemo(id: UUID) {
        guard let index = list.firstIndex(where: {$0.id == id}) else {
            return
        }
        list.remove(at: index)
    }
    
    func fetchMemos() -> [Memo] {
        return list
    }
    
    func toggleLike(id: UUID) {
        guard let index = list.firstIndex(where: {$0.id == id}) else {
            return
        }
        _ = list[index].toggleLike()
    }
    
    func searchMemos(keyword: String) -> [Memo] {
        return list.filter { memo in
            memo.title.contains(keyword) || memo.content.contains(keyword)
        }
    }
    
}
