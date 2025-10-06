//
//  MemoUseCase.swift
//  CoreDataDemo-UIKit
//
//  Created by 이승준 on 10/6/25.
//

import Foundation

class MemoUseCase: MemoUseCaseProtocol {
    
    private var memoCoreDatarepository: MemoCoreDataRepositoryProtocol
    
    init(memoCoreData: MemoCoreDataRepositoryProtocol) {
        self.memoCoreDatarepository = memoCoreData
    }
    
    func addMemo(title: String, content: String) {
        let memo = Memo(title: title, content: content)
        switch memoCoreDatarepository.saveMemo(memo) {
        case .success(_):
            return print("save success")
        case .failure(let error):
            return print(error)
        }
    }
    
    func editMemo(memo: Memo) {
        switch memoCoreDatarepository.editMemo(memo) {
        case .success(_):
            return print("edit \(memo) success")
        case .failure(let error):
            return print(error)
        }
    }
    
    func deleteMemo(memo: Memo) {
        switch memoCoreDatarepository.deleteMemo(memo) {
        case .success(_):
            return print("delete \(memo.title) success")
        case .failure(let error):
            return print(error)
        }
    }
    
    func fetchMemos() -> [Memo]? {
        switch memoCoreDatarepository.getAllMemos() {
        case .success(let memos):
            return memos
        case .failure(let error):
            print(error)
            return nil
        }
    }
    
    func toggleLike(memo: Memo) {
        switch memoCoreDatarepository.editMemo(memo) {
        case .success(_):
            return print("change like state of \(memo) to \(memo.liked) is successed")
        case .failure(let error):
            return print(error)
        }
    }
    
    func searchMemos(keyword: String) -> [Memo] {
        return []
    }
    
}
