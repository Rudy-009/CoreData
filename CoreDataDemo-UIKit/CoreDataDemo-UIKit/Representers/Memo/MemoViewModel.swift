//
//  MemoViewModel.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 9/5/25.
//

import Combine
import Foundation

final class MemoViewModel: ObservableObject, MemoUseCaseProtocol {
    
    private var cancellables: Set<AnyCancellable> = []
    private var memoCoreData: MemoCoreDataRepositoryProtocol
    
    var listPublisher: AnyPublisher<[Memo], Never> {
        $list.eraseToAnyPublisher()
    }
    
    @Published var list: [Memo] = []

    init(memoCoreData: MemoCoreDataRepositoryProtocol) {
        self.memoCoreData = memoCoreData
    }
        
    func addMemo(title: String, content: String) {
        let memo = Memo(title: title, content: content)
        switch memoCoreData.saveMemo(memo) {
        case .success(let success):
            list.append(memo)
            print("add succeess: \(success)")
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func editMemo(id: UUID, title: String?, content: String?) {
        guard let index = list.firstIndex(where: {$0.id == id}) else { return }
        list[index].edit(title: title, content: content)
        switch memoCoreData.editMemo(list[index]) {
        case .success(let success):
            print("edit success: \(success)")
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func deleteMemo(id: UUID) {
        guard let index = list.firstIndex(where: {$0.id == id}) else { return }
        switch memoCoreData.deleteMemo(list[index]) {
        case .success(_):
            list.remove(at: index)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func fetchMemos() -> [Memo]? {
        switch memoCoreData.getAllMemos() {
        case .success(let success):
            self.list = success
            return success
        case .failure(let failure):
            print(failure.localizedDescription)
            return nil
        }
    }
    
    func toggleLike(id: UUID) {
        guard let index = list.firstIndex(where: {$0.id == id}) else { return }
        _ = list[index].toggleLike()
        switch memoCoreData.editMemo(list[index]) {
        case .success(let success):
            print("toggle succeed")
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func searchMemos(keyword: String) -> [Memo] {
        return list.filter { memo in
            memo.title.contains(keyword) || ((memo.content?.contains(keyword)) != nil)
        }
    }
    
}
