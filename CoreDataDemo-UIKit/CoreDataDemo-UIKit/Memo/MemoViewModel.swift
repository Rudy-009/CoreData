//
//  MemoViewModel.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Combine
import Foundation

final class MemoViewModel: ObservableObject, MemoModelProtocol {
    
    private var cancellables: Set<AnyCancellable> = []
    
    var listPublisher: AnyPublisher<[Memo], Never> {
        $list.eraseToAnyPublisher()
    }
    @Published var list: [Memo] = [
        Memo(title: "title", content: "lorem lorem lorem lorem lorem lorem lorem lorem lorem lorem ", liked: true),
        Memo(title: "bread recipe", content: "bread recipe bread recipe bread recipe bread recipe bread recipe bread recipe ", liked: false),
        Memo(title: "birthday plan", content: "birthday plan birthday plan birthday plan birthday plan birthday plan", liked: false),
    ]
    
    init() {
        
    }
    
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
            memo.title.contains(keyword) || ((memo.content?.contains(keyword)) != nil)
        }
    }
    
}
